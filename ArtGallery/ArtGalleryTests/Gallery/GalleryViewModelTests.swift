@testable import ArtGallery
@testable import NetworkingModule
import Combine
import Foundation
import XCTest


class ListViewModelTests: XCTestCase {
    private var viewModel: GalleryViewModel!
    private let responseObject = ArtAsset(id: "id", title: "title", artist: "artist", imageAsset: ArtAssetImage(imageUrl: "imageUrl", width: 1, height: 1))
    private let responseObjectTwo = ArtAsset(id: "id2", title: "title2", artist: "artist2", imageAsset: ArtAssetImage(imageUrl: "imageUrl2", width: 1, height: 1))
    private var disposables: Set<AnyCancellable>!
    
    override func setUpWithError() throws {
        viewModel = GalleryViewModel(MockGalleryViewModelDependency([responseObject]))
        disposables = []
    }
    
    func testSearch() {
        let expectedResult = ArtViewModel(id: responseObject.id, title: responseObject.title, artist: responseObject.artist, imageAsset: RemoteImageViewModel(imageUrl: responseObject.imageAsset.imageUrl, width: responseObject.imageAsset.width, height: responseObject.imageAsset.height))
        viewModel.subscribe()
        viewModel.searchInput.send("Test")
        let expectation = XCTestExpectation(description: "Search")
        viewModel.$items.sink(receiveValue: { value in
            if value == [expectedResult] {
                expectation.fulfill()
            }
        }).store(in: &disposables)
        wait(for: [expectation], timeout: 1)
    }
    func testPagination() {
        viewModel = GalleryViewModel(MockGalleryViewModelDependency([responseObjectTwo]))
        let responseObjectOneViewModel = ArtViewModel(id: responseObject.id, title: responseObject.title, artist: responseObject.artist, imageAsset: RemoteImageViewModel(imageUrl: responseObject.imageAsset.imageUrl, width: responseObject.imageAsset.width, height: responseObject.imageAsset.height))
        let responseObjectTwoViewModel = ArtViewModel(id: responseObjectTwo.id, title: responseObjectTwo.title, artist: responseObjectTwo.artist, imageAsset: RemoteImageViewModel(imageUrl: responseObjectTwo.imageAsset.imageUrl, width: responseObjectTwo.imageAsset.width, height: responseObjectTwo.imageAsset.height))
        let expectedResult = [responseObjectOneViewModel, responseObjectTwoViewModel]
        viewModel.items = [responseObjectOneViewModel]
        viewModel.prefetchIfNeeded(0)
        let expectation = XCTestExpectation(description: "Pagination")
        viewModel.$items.sink(receiveValue: { value in
            if value == expectedResult {
                expectation.fulfill()
            }

        }).store(in: &disposables)
        wait(for: [expectation], timeout: 1)
    }
}

