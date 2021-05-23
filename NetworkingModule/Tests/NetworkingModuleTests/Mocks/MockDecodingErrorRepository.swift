@testable import ModelsModule
@testable import NetworkingModule
import Combine
import Foundation

final class MockDecodingErrorRepository: IEndpointRepository {
    func request<T>(_ url: URL) -> AnyPublisher<T, EndpointError> where T : Decodable {
        return Fail(error: .decodingFailure(DecodingError.dataCorrupted(.init(codingPath: [], debugDescription: "")))).eraseToAnyPublisher()
    }
}
