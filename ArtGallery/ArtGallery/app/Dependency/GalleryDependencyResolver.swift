import NetworkingModule
protocol IGalleryDependencyResolver {
    func resolve(_ api: API) -> ArtResolver
}

/**
 Resolves dependencies to interact with a specified `api`
 */
struct GalleryDependencyResolver: IGalleryDependencyResolver {
    private let manager: IAPIManager
    init(_ manager: IAPIManager = APIManager()) {
        self.manager = manager
    }
    func resolve(_ api: API) -> ArtResolver {
        switch api {
        case .rijksMuseum:
            return RijksMuseumQueryBuilder(manager.base(for: api), usecase: RijksMuseumQueryUsecase())
        }
    }
}
