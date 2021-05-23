import SwiftUI
struct GalleryGridItem: View {
    private let item: ArtViewModel
    private let imageUrlManipulator: ImageUrlManipulator
    private let containerProxy: GeometryProxy
    private let config: CardConfiguration
    init(_ item: ArtViewModel, manipulator: ImageUrlManipulator, proxy: GeometryProxy, configuration: CardConfiguration) {
        self.item = item
        imageUrlManipulator = manipulator
        containerProxy = proxy
        config = configuration
    }
    var body: some View {
        VStack {
            image(config)
            detailStack(config)
        }
    }
    /**
     Load an image based on the configuration with a respectful size.
     */
    @ViewBuilder private func image(_ config: CardConfiguration) -> some View {
        if config == .grid {
            DynamicImage(item, manipulator: imageUrlManipulator, configuration: config).aspectRatio(1, contentMode: .fit)
        }
        else {
            let availableWidth = containerProxy.size.width - 32 // Not ideal
            let targetHeight = resolveTargetHeight(for: availableWidth)
            DynamicImage(item, manipulator: imageUrlManipulator, configuration: config).frame(width: availableWidth, height: targetHeight)
        }
    }
    
    /// Calculate a target height given the available with with respect to assets aspect ratio
    private func resolveTargetHeight(for width: CGFloat) -> CGFloat {
        let aspectRatio: CGFloat = item.imageAsset.aspectRatio == 0 ? 1 : item.imageAsset.aspectRatio.cgFloat
        return width / aspectRatio
    }
    
    /**
     The detail stack with a background containing the associated details about the asset.
     
     In `list` mode, we support text wrapping while in `grid` we restrict to one line.
     */
    @ViewBuilder private func detailStack(_ config: CardConfiguration) -> some View {
        VStack(alignment: .leading) {
            Text(item.title).font(.body).bold().lineLimit(config == .grid ? 1 : nil)
            Text(item.artist).font(.subheadline).lineLimit(config == .grid ? 1 : nil)
        }.frame(maxWidth: .infinity, alignment: .leading).padding().background(Color(ColorScheme.secondaryBackground.rawValue))
    }
}
