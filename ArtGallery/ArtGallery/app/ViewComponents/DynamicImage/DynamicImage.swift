import SwiftUI
import Kingfisher
/**
 Loads an image from a remote url that is automatically sized to its container.
 
 If the url supports server side sizing and cropping, that option is used.
 If server-side manipulation is unavailable, downsampling is used.
 
 */
struct DynamicImage: View {
    private let url: URL?
    private let imageUrlManipulator: ImageUrlManipulator
    private let asset: ArtViewModel
    private let config: CardConfiguration
    init(_ data: ArtViewModel, manipulator: ImageUrlManipulator, configuration: CardConfiguration) {
        asset = data
        url = URL(string: data.imageAsset.imageUrl)
        imageUrlManipulator = manipulator
        config = configuration
    }
    var body: some View {
        GeometryReader { geo in
            remoteImage(targetSize: geo.size)
                .cancelOnDisappear(true)
                .fade(duration: 0.15)
        }
    }
    private func remoteImage(targetSize: CGSize) -> KFImage {
        switch imageUrlManipulator {
        case .none:
            return downSampledImage(targetSize)
        case .google(let manipulator):
            manipulator.height(targetSize.height).width(targetSize.width)
            if config == .grid {
                manipulator.smartCrop()
            }
            return serverSizedImage(manipulator.url())
        }
    }
    /**
     Download & Cache the original Image while while Downsampling the result
     in order to to reduce memory load while maintaining a respectable pixel ratio.
     */
    private func downSampledImage(_ size: CGSize) -> KFImage {
        return KFImage(url)
            .setProcessor(DownsamplingImageProcessor(size: size))
            .cacheOriginalImage()
            .scaleFactor(UIScreen.main.scale)
    }
    /**
     Request a scaled image from the server that fits the view.
     The downloaded image respects the device scaleFactor.
     */
    private func serverSizedImage(_ modifiedImageUrl: URL?) -> KFImage {
        return KFImage(modifiedImageUrl)
            .resizable()
            .onFailure { error in
                // Log Error & Configure a Backup Strategy
            }
    }
}
