struct RemoteImageViewModel: Equatable {
    let imageUrl: String
    let width, height: Double
    var aspectRatio: Double {
        get {
            return width / height
        }
    }
}
