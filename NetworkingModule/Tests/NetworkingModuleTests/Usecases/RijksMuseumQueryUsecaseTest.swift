import XCTest
import Combine
@testable import NetworkingModule
@testable import ModelsModule
final class RijksMuseumQueryUsecaseTests: XCTestCase {
    private var disposables: Set<AnyCancellable>!
    override func setUp() {
        disposables = []
    }
    func testSuccessResponse() {
        let repository = MockSuccessRepository()
        let usecase = RijksMuseumQueryUsecase(repository)
        let expectedResponse = [ArtAsset(id: "id", title: "title", artist: "maker", imageAsset: ArtAssetImage(imageUrl: "imageUrl", width: 1, height: 1))]
        let expectation = XCTestExpectation(description: "successResponse")
        usecase.query(URL(string: "test.com")!)
            .sink(receiveCompletion: {_ in }, receiveValue: { result in
                XCTAssertEqual(result.compactMap { $0 as? ArtAsset }, expectedResponse)
                expectation.fulfill()
            })
            .store(in: &disposables)
        wait(for: [expectation], timeout: 1)
    }
    func testUrlErrorResponse() {
        let repository = MockUrlErrorRepository()
        let usecase = RijksMuseumQueryUsecase(repository)
        let expectation = XCTestExpectation(description: "urlErrorResponse")
        usecase.query(URL(string: "test.com")!)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    if case EndpointError.invalidResponse(_) = error {
                        expectation.fulfill()
                    }
                case .finished:
                    XCTFail()
                }
            }, receiveValue: { _ in
            })
            .store(in: &disposables)
        wait(for: [expectation], timeout: 1)
    }
    func testDecodingErrorResponse() {
        let repository = MockDecodingErrorRepository()
        let usecase = RijksMuseumQueryUsecase(repository)
        let expectation = XCTestExpectation(description: "decodingErrorResponse")
        usecase.query(URL(string: "test.com")!)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    if case EndpointError.decodingFailure(_) = error {
                        expectation.fulfill()
                    }
                case .finished:
                    XCTFail()
                }
            }, receiveValue: { _ in
            })
            .store(in: &disposables)
        wait(for: [expectation], timeout: 1)
    }
}
