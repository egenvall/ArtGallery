import Foundation
import Combine
protocol IEndpointRepository {
    func request<T: Decodable>(_ url: URL) -> AnyPublisher<T, EndpointError>
}
