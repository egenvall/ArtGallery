import SwiftUI
struct GalleryView<ViewModel: IGalleryViewModel>: View {
    @ObservedObject var viewModel: ViewModel
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    var body: some View {
        ZStack(alignment: .top) {
            DynamicGridView(viewModel.items) { context in
                let (item, proxy, config, index) = context
                Color.blue.frame(width: proxy.size.width - 32, height: 50)
            }
        }.onAppear {
            viewModel.subscribe()
        }.onReceive(horizontalSizeClass.publisher) { sizeClass in
            
        }
    }
    private func updateConfiguration(_ config: CardConfiguration) {
        viewModel.updateConfiguration(config)
    }
}
