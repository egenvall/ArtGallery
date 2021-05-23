import Foundation
import Combine

public class GetQueryUsecase<T: Decodable>: IGetQueryUsecase {
    private var repository: IEndpointRepository

    public init() {
        self.repository = EndpointRepository()
    }
    init(_ repository: IEndpointRepository = EndpointRepository()) {
        self.repository = repository
    }
    public func query(_ url: URL) -> AnyPublisher<T, EndpointError> {
        repository.request(url)
    }
}
