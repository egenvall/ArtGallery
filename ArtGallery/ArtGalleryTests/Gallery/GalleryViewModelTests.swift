@testable import ArtGallery
@testable import NetworkingModule
import Combine
import Foundation
import XCTest


class ListViewModelTests: XCTestCase {
    private var viewModel: GalleryViewModel!
    private let assetOne = ArtAsset(id: "id", title: "title", artist: "artist", imageAsset: ArtAssetImage(imageUrl: "imageUrl", width: 1, height: 1))
        
    private let assetTwo = ArtAsset(id: "id2", title: "title2", artist: "artist2", imageAsset: ArtAssetImage(imageUrl: "imageUrl2", width: 1, height: 1))
    
    private var disposables: Set<AnyCancellable>!
    override func setUpWithError() throws {
        //viewModel = GalleryViewModel(Mock)
        disposables = []
    }
    
    func testSearch() {
//        let expectedResult = ArtViewModel(id: asset.id, title: asset.title, artist: asset.artist, imageAsset: RemoteImageViewModel(imageUrl: asset.imageAsset.imageUrl, width: asset.imageAsset.width, height: asset.imageAsset.height))
//        viewModel.subscribe()
//        viewModel.searchInput.send("Test")
//        let expectation = XCTestExpectation(description: "Search")
//        viewModel.$items.sink(receiveValue: { value in
//            if value == [expectedResult] {
//                expectation.fulfill()
//            }
//        }).store(in: &disposables)
//        wait(for: [expectation], timeout: 1)
    }
    func testPagination() {
//        let expectedResult = ArtViewModel(id: asset.id, title: asset.title, artist: asset.artist, imageAsset: RemoteImageViewModel(imageUrl: asset.imageAsset.imageUrl, width: asset.imageAsset.width, height: asset.imageAsset.height))
//        viewModel.items = [expectedResult]
//        viewModel.prefetchIfNeeded(0)
//        let expectation = XCTestExpectation(description: "Pagination")
//        viewModel.$items.sink(receiveValue: { value in
//            if value.count == 2 {
//                if value == [expectedResult, expectedResult] {
//                    expectation.fulfill()
//                }
//            }
//            
//        }).store(in: &disposables)
//        wait(for: [expectation], timeout: 1)
    }
}

