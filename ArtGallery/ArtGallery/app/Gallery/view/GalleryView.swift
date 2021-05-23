import SwiftUI
struct GalleryView<ViewModel: IGalleryViewModel>: View {
    @ObservedObject var viewModel: ViewModel
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    var body: some View {
        ZStack(alignment: .top) {
            Color(ColorScheme.background.rawValue).edgesIgnoringSafeArea(.all)
            // TODO: Make it state based to handle all scenarios
            if viewModel.items.isEmpty {
                GalleryEmptyStateView().ignoresSafeArea(.keyboard)
            }
            else {
                DynamicGridView(viewModel.items, topInset: 100) { context in
                    let (item, proxy, config, index) = context
                    GalleryGridItem(item, manipulator: viewModel.imageManipulator(item.imageAsset.imageUrl), proxy: proxy, configuration: config)
                        .onAppear {
                            viewModel.prefetchIfNeeded(index)
                        }
                }.id(1).animation(.default)
            }
            
            SearchContainer(text: viewModel.searchInput)
        }.onAppear {
            viewModel.subscribe()
        }.onReceive(horizontalSizeClass.publisher) { sizeClass in
            updateConfiguration(sizeClass == .compact ? .list : .grid)
        }
    }
    private func updateConfiguration(_ config: CardConfiguration) {
        viewModel.updateConfiguration(config)
    }
}
