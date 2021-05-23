import Combine
import Foundation
public protocol IArtQueryUsecase: AnyObject {
    func query(_ url: URL) -> AnyPublisher<[IArtAsset], EndpointError>
}
