import NetworkingModule
import Combine
import Foundation
final class MockGalleryViewModelDependency: ArtResolver {
    private let assetResponse: [ArtAsset]
    init(_ responseObject: [ArtAsset]) {
        self.assetResponse = responseObject
    }
    func addParameter(_ param: QueryParameter) -> IQueryBuilder {
        fatalError()
    }
    
    func build() -> URL? {
        return nil
    }
    
    func search(_ text: String) -> AnyPublisher<[IArtAsset], EndpointError> {
        Just(assetResponse).setFailureType(to: EndpointError.self).eraseToAnyPublisher()
    }
    
    func paginate() -> AnyPublisher<[IArtAsset], EndpointError> {
        Just(assetResponse).setFailureType(to: EndpointError.self).eraseToAnyPublisher()
    }
}
