import SwiftUI
/**
 Adaptive Grid which changes its layout based on the current horizontal size class
 */
struct DynamicGridView<Data: RandomAccessCollection, Content: View>: View where Data.Index == Int {
    typealias DynamicItemContext = (Data.Element, GeometryProxy, CardConfiguration, Int)
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    private let items: Data
    private let topInset: CGFloat
    
    private var content: (DynamicItemContext) -> Content
    init(_ data: Data, topInset: CGFloat = .zero, @ViewBuilder content: @escaping (DynamicItemContext) -> Content) {
        self.items = data
        self.topInset = topInset
        self.content = content
    }
    
    var body: some View {
        GeometryReader { geo in
            ScrollView(showsIndicators: false) {
                Color.clear.frame(height: topInset)
                grid(geo)
            }
        }.ignoresSafeArea(.keyboard)
    }
    
    @ViewBuilder private func grid(_ proxy: GeometryProxy) -> some View {
        LazyVGrid(columns: generateGridLayout(), alignment: .leading) {
            ForEach(0..<items.count, id: \.self) { index in
                gridItem(items[index], index: index, proxy: proxy)
            }
        }
        .padding(.horizontal)
    }
    
    @ViewBuilder private func gridItem(_ item: Data.Element, index: Int, proxy: GeometryProxy) -> some View {
        content((item, proxy, getConfiguration(), index))
    }
    private func getConfiguration() -> CardConfiguration {
        switch horizontalSizeClass {
        case .regular:
            return .grid
        case .compact:
            return .list
        default:
            return .grid
        }
    }
    /**
     Generate a dynamic grid layout based on the current environment.
     
     For iPhone portrait and some split screen configurations we mimick a list layout.
     For larger sizes, we use an adaptive grid to fit a reasonable amount of content in one row.
     */
    private func generateGridLayout() -> [GridItem] {
        let config = getConfiguration()
        switch config {
        case .list:
            return [.init(.flexible(minimum: 100, maximum: .infinity))]
        case .grid:
            return [.init(.adaptive(minimum: 250, maximum: 450))]
        }
    }
}
