import Combine
public protocol IArtQueryResolver {
    func search(_ text: String) -> AnyPublisher<[IArtAsset], EndpointError>
    func paginate() -> AnyPublisher<[IArtAsset], EndpointError>
}
