import SwiftUI
struct GalleryView<ViewModel: IGalleryViewModel>: View {
    @ObservedObject var viewModel: ViewModel
    var body: some View {
        Color.blue
    }
}
