import SwiftUI
struct AppViewFactory: RootViewFactory {
    func build(_ route: AppRoute) -> some View {
        switch route {
        case .gallery:
            return GalleryViewFactory().build()
        }
    }
}
