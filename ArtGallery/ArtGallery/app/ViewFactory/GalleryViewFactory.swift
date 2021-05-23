import SwiftUI
struct GalleryViewFactory: ViewFactory {
    func build() -> some View {
        return Color.red
        //return GalleryView(viewModel: GalleryViewModel(<#T##resolver: ArtResolver##ArtResolver#>))
    }
}
