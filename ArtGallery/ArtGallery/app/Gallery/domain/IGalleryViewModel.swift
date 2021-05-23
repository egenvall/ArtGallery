import Combine
protocol IGalleryViewModel: ObservableObject {
    func subscribe()
    func prefetchIfNeeded(_ currentIndex: Int)
}
