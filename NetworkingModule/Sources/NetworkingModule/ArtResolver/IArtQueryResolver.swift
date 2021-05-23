import Combine
public protocol IArtQueryResolver {
    func search(_ text: String) -> AnyPublisher<[IAssetData], EndpointError>
    func paginate() -> AnyPublisher<[IAssetData], EndpointError>
}
