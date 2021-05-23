public struct ArtAsset: IArtAsset, Equatable {
    public static func == (lhs: ArtAsset, rhs: ArtAsset) -> Bool {
        return lhs.id == rhs.id // Quite Naive
    }
    public let id, title, artist: String
    public let imageAsset: IArtAssetImage
    init(id: String, title: String, artist: String, imageAsset: IArtAssetImage) {
        self.id = id
        self.title = title
        self.artist = artist
        self.imageAsset = imageAsset
    }
}
