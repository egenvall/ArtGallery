@testable import ModelsModule
@testable import NetworkingModule
import Combine
import Foundation

final class MockUrlErrorRepository: IEndpointRepository {
    func request<T>(_ url: URL) -> AnyPublisher<T, EndpointError> where T : Decodable {
        return Fail(error: .invalidResponse(URLError(.badServerResponse))).eraseToAnyPublisher()
    }
}
