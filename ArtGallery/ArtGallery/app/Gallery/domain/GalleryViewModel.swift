import Combine
import NetworkingModule
import Foundation
import Kingfisher
final class GalleryViewModel: IGalleryViewModel {
    // MARK: - IGalleryViewModel Properties
    @Published var items: [ArtViewModel] = []
    var searchInput = PassthroughSubject<String, Never>()
    
    // MARK: - Internal
    private let resolver: ArtResolver
    private let serverScalingDeterminator = ServerScalingDeterminator()
    private var disposables = Set<AnyCancellable>()
    private typealias QueryPublisher = AnyPublisher<[IArtAsset], EndpointError>
    
    // MARK: - Configuration
    
    /// Describes the layout of the GalleryView
    var configuration: CardConfiguration = .grid {
        didSet {
            resolver.addParameter(.resultsPerPage(pageSize))
        }
    }
    /// Determines the sensitivity of when to start loading more items
    private var prefetchSensitivity: Int {
        get {
            return configuration == .list ? items.count - 3 : items.count - 12
        }
    }
    ///The number of results to request from a query
    private var pageSize: Int {
        get {
            return configuration == .list ? 10 : 20
        }
    }
    init(_ resolver: ArtResolver) {
        ImageCache.default.memoryStorage.config.totalCostLimit = 1024 * 1024 * 100
        self.resolver = resolver
    }
    
    
    // MARK: - Search Subscription
    /**
     Subscribes to updates of `searchInput` and performs a new `search` after a debounce.
     The `search` will not be performed on duplicated or empty text.
     */
    private func monitorSearchInput() {
        searchInput
            .debounce(for: .seconds(0.8), scheduler: RunLoop.main)
            .removeDuplicates()
            .filter { !$0.isEmpty }
            .sink { [weak self] searchQuery in
                self?.search(searchQuery)
            }.store(in: &disposables)
    }
    
    // MARK: - Querying
    /// Performs a query with `text`
    private func search(_ text: String) {
        // TODO: Scroll to top
        ImageCache.default.clearMemoryCache()
        query(resolver.search(text)) { [weak self] newItems in
            self?.items = newItems
        }
    }
    /// Paginate and load more results
    private func paginate() {
        query(resolver.paginate()) { [weak self] newItems in
            self?.items.append(contentsOf: newItems)
        }
    }
    private func query(_ publisher: QueryPublisher, onResult: @escaping ([ArtViewModel]) -> Void) {
        publisher
            .map { list -> [ArtViewModel] in
                return list.map { item in
                    ArtViewModel(
                        id: item.id, title: item.title, artist: item.artist,
                        imageAsset: RemoteImageViewModel(imageUrl: item.imageAsset.imageUrl, width: item.imageAsset.width, height: item.imageAsset.height)
                    )
                }
            }.mapError { error -> GalleryError in
                switch error {
                case .decodingFailure(_):
                    return .modelError
                case .invalidResponse(_):
                    return .serverError
                case .invalidUrlRequest, .paginationError:
                    return .internalError
                }
            }
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.displayError(error)
                case .finished:
                    break
                }
            }, receiveValue: { art in
                onResult(art)
            }).store(in: &disposables)
    }
    
    // MARK: - Result Management
    private func displayError(_ error: GalleryError) {
        // EventLogger.log...
        // TODO: Toggle Published property that displays a banner for a few seconds
    }
    // MARK: - Protocol Conforming Functions
    /// Update the internal configuration if needed when the environment changes
    func updateConfiguration(_ config: CardConfiguration) {
        guard configuration != config else {
            return
        }
        configuration = config
    }
    /// Initiates Content Flow
    func subscribe() {
        monitorSearchInput()
        search("")
    }
    
    /// Returns a type of ImageUrlManipulator for the `imageUrl` if present, else `.none`
    func imageManipulator(_ imageUrl: String) -> ImageUrlManipulator {
        return serverScalingDeterminator.getImageUrlManipulator(imageUrl)
    }
    /**
     Begin a pagination if the currentIndex matches the `prefetchSensitivity`.
     
     Will also try to paginate if the `prefetchSensitivity` is less than 0 and `currentIndex` matches
     `items.count`
     */
    func prefetchIfNeeded(_ currentIndex: Int) {
        guard !items.isEmpty else {
            return
        }
        let targetIndex = prefetchSensitivity < 0 ? items.count - 1 : prefetchSensitivity
        guard currentIndex == targetIndex  else {
            return
        }
        paginate()
    }
}
