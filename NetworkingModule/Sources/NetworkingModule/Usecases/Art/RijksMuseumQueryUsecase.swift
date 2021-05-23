import Foundation
import Combine
import ModelsModule
public final class RijksMuseumQueryUsecase: GetQueryUsecase<RijksMuseumAPIResponse>, IArtQueryUsecase {
    public func query(_ url: URL) -> AnyPublisher<[IArtAsset], EndpointError> {
        super.query(url)
            .map { data -> [IArtAsset] in
            data.artObjects.map { item in
                ArtAsset(id: item.id, title: item.title, artist: item.principalOrFirstMaker,
                         imageAsset: ArtAssetImage(
                            imageUrl: item.webImage.url,
                            width: Double(item.webImage.width),
                            height: Double(item.webImage.height)
                         )
                )
            }
        }.eraseToAnyPublisher()
    }
}
