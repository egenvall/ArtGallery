import Combine
import NetworkingModule
final class GalleryViewModel: IGalleryViewModel {
    private let resolver: ArtResolver
    init(_ resolver: ArtResolver) {
        self.resolver = resolver
    }
    func subscribe() {
        
    }
    
    func prefetchIfNeeded(_ currentIndex: Int) {
        
    }
}
