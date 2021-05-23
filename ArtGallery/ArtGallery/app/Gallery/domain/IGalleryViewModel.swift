import Combine
protocol IGalleryViewModel: ObservableObject {
    var items: [ArtViewModel] { get }
    var searchInput: PassthroughSubject<String, Never> { get }
    func prefetchIfNeeded(_ currentIndex: Int)
    func subscribe()
    func updateConfiguration(_ config: CardConfiguration)
}
