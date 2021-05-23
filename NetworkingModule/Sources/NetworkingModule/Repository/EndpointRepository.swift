import Foundation
import Combine

struct EndpointRepository: IEndpointRepository {
    private var decoder = JSONDecoder()
    public init(){}
    public func request<T: Decodable>(_ url: URL) -> AnyPublisher<T, EndpointError> {
        URLSession.shared
            .dataTaskPublisher(for: url) // A caching strategy is needed
            .mapError { error -> EndpointError in
                // EventLogger.log...
                EndpointError.invalidResponse(error)
            }
            .map(\.data)
            .decode(type: T.self, decoder: decoder)
            .mapError { error in
                // EventLogger.log...
                EndpointError.decodingFailure(error)
            }
            .eraseToAnyPublisher()
    }
}

