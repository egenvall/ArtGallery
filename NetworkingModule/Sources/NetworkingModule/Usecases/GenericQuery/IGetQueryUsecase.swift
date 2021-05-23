import Foundation
import Combine
public protocol IGetQueryUsecase: AnyObject {
    associatedtype T: Decodable
    func query(_ url: URL) -> AnyPublisher<T, EndpointError>
}
