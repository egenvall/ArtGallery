import SwiftUI

struct GalleryViewFactory: ViewFactory {
    private let resolver: IGalleryDependencyResolver
    private let api: API
    init(_ api: API, dependencyResolver: IGalleryDependencyResolver) {
        self.api = api
       resolver = dependencyResolver
    }
    func build() -> some View {
        return GalleryView(viewModel: GalleryViewModel(resolver.resolve(api)))
    }
}
