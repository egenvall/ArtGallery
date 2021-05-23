import SwiftUI
struct AppViewFactory: RootViewFactory {
    private let manager = APIManager()
    func build(_ route: AppRoute) -> some View {
        switch route {
        case .gallery:
            return GalleryViewFactory(.rijksMuseum, dependencyResolver: GalleryDependencyResolver(manager)).build()
        }
    }
}
