public struct ArtAssetImage: IArtAssetImage {
    public let imageUrl: String
    public let width: Double
    public let height: Double
    public var aspectRatio: Double {
        get {
            return width / height
        }
    }
    init(imageUrl: String, width: Double, height: Double) {
        self.imageUrl = imageUrl
        self.width = width
        self.height = height
    }
}
