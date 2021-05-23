@testable import ModelsModule
@testable import NetworkingModule
import Combine
import Foundation
final class MockSuccessRepository: IEndpointRepository {
    func request<T>(_ url: URL) -> AnyPublisher<T, EndpointError> where T : Decodable {
        return Just(RijksMuseumAPIResponse(artObjects: [ArtObject(principalOrFirstMaker: "maker", id: "id", title: "title", webImage: RijksMuseumImage(width: 1, height: 1, url: "imageUrl"))]) as! T).setFailureType(to: EndpointError.self).eraseToAnyPublisher()
    }
}

