import Combine
import NetworkingModule
final class GalleryViewModel: IGalleryViewModel {
    typealias QueryPublisher = AnyPublisher<IArtAsset, EndpointError>
    @Published var items: [ArtViewModel] = []
    var searchInput = PassthroughSubject<String, Never>()
    private let resolver: ArtResolver
    private var disposables = Set<AnyCancellable>()
    init(_ resolver: ArtResolver) {
        self.resolver = resolver
    }
    func subscribe() {
        
    }
    func prefetchIfNeeded(_ currentIndex: Int) {
        
    }
    
    // MARK: - Querying
    /// Performs a query with `text`
    private func search(_ text: String) {
        
    }
    /// Paginate and load more results
    private func paginate() {
        
    }
    private func query(_ publisher: QueryPublisher, onResult: @escaping ([ArtViewModel]) -> Void) {
        
    }
    
    // MARK: - Result Management
    private func displayError(_ error: GalleryError) {
        
    }
}
