import XCTest
@testable import NetworkingModule

final class RijksMuseumQueryBuilderTests: XCTestCase {
    private var builder: IQueryBuilder!
    private let baseUrl = "https://www.testurl.com?param=abc"
    private let onlyImages = "&imgonly=True"

    override func setUpWithError() throws {
        builder = RijksMuseumQueryBuilder(baseUrl, usecase: RijksMuseumQueryUsecase(MockSuccessRepository()))
    }

    func testInitialConfiguration() {
        let result = builder.build()
        XCTAssertNotNil(result)
    }
    func testSetPage() {
        let result = builder.addParameter(.page(2)).build()
        let control = baseUrl + onlyImages + "&p=2"
        XCTAssertEqual(result?.absoluteString, control)
    }
    func testAddPageSize() {
        let result = builder.addParameter(.resultsPerPage(2)).build()
        let control = baseUrl + onlyImages + "&ps=2"
        XCTAssertEqual(result?.absoluteString, control)
    }
    func testAddSearchQuery() {
        let result = builder.addParameter(.searchTerm("2")).build()
        let control = baseUrl + onlyImages + "&q=2"
        XCTAssertEqual(result?.absoluteString, control)
    }
    func testAddChained() {
        let result = builder.addParameter(.searchTerm("2")).addParameter(.page(1)).addParameter(.resultsPerPage(10)).build()
        let control = baseUrl + onlyImages + "&q=2&p=1&ps=10"
        XCTAssertEqual(result?.absoluteString, control)
    }
    func testResetWhenBuild() {
        let _ = builder
            .addParameter(.page(2))
            .addParameter(.resultsPerPage(20))
            .addParameter(.searchTerm("Hello World"))
            .build()
        
        let freshResult = builder.build()
        XCTAssertEqual(freshResult?.absoluteString, baseUrl + onlyImages)
    }
}
