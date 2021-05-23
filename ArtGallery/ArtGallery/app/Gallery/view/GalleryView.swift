import SwiftUI
struct GalleryView<ViewModel: IGalleryViewModel>: View {
    @ObservedObject var viewModel: ViewModel
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    var body: some View {
        ZStack(alignment: .top) {
            
        }.onAppear {
            viewModel.subscribe()
        }.onReceive(horizontalSizeClass.publisher) { sizeClass in
            
        }
    }
    private func updateConfiguration(_ config: CardConfiguration) {
        viewModel.updateConfiguration(config)
    }
}
