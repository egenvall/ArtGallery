import SwiftUI
struct GalleryView<ViewModel: IGalleryViewModel>: View {
    @ObservedObject var viewModel: ViewModel
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    var body: some View {
        ZStack(alignment: .top) {
            Color(ColorScheme.background.rawValue).edgesIgnoringSafeArea(.all)
            DynamicGridView(viewModel.items, topInset: 100) { context in
                let (item, proxy, config, index) = context
                GalleryGridItem(item, manipulator: viewModel.imageManipulator(item.imageAsset.imageUrl), proxy: proxy, configuration: config)
                    .onAppear {
                        viewModel.prefetchIfNeeded(index)
                    }
            }
            SearchContainer(text: viewModel.searchInput)
        }.onAppear {
            viewModel.subscribe()
        }.onReceive(horizontalSizeClass.publisher) { sizeClass in
            updateConfiguration(sizeClass == .compact ? .list : .grid)
        }.animation(.default)
    }
    private func updateConfiguration(_ config: CardConfiguration) {
        viewModel.updateConfiguration(config)
    }
}
