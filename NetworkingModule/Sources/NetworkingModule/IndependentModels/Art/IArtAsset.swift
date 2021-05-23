public protocol IArtAsset {
    var id: String { get }
    var title: String { get }
    var artist: String { get }
    var imageAsset: IArtAssetImage { get }
}
