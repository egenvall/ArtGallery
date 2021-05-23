import Combine
protocol IGalleryViewModel: ObservableObject {
    var items: [ArtViewModel] { get }
    func subscribe()
    func prefetchIfNeeded(_ currentIndex: Int)
}
