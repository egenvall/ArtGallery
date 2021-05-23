import Foundation
import Combine
/**
 QueryBuilder for the RijksMuseum API that formats the available parameters
 according to API conformance
 */
public class RijksMuseumQueryBuilder: IQueryBuilder, IArtQueryResolver {
    private let queryUsecase: IArtQueryUsecase
    private var currentPage = QueryParameter.page(1)
    private var resultsPerPage = QueryParameter.resultsPerPage(20)
    private var currentSearchTerm = QueryParameter.searchTerm("")
    private let queryManager: QueryBuildManager
    public init(_ base: String, usecase: IArtQueryUsecase) {
        queryUsecase = usecase
        // Adds &imgonly=True to our base as we just want responses with images right now.
        queryManager = QueryBuildManager(base+"&imgonly=True")
    }
    
    /**
     Adds a correctly formatted `query` to the concrete implementation of the api.
     */
    @discardableResult public func addParameter(_ param: QueryParameter) -> IQueryBuilder {
        queryManager.addParameter(resolveParameter(param))
        return self
    }
    /**
     Transform a `QueryParameter` to its final `URLQueryItem` form who's key
     is correctly formatted for usage with the endpoint of `queryUsecase`
     */
    private func resolveParameter(_ param: QueryParameter) -> URLQueryItem {
        switch param {
        case .page(let number):
            currentPage = param
            return URLQueryItem(name: "p", value: "\(number)")
        case .resultsPerPage(let amount):
            resultsPerPage = param
            return URLQueryItem(name: "ps", value: "\(amount)")
        case .searchTerm(let searchTerm):
            currentSearchTerm = param
            return URLQueryItem(name: "q", value: searchTerm)
        }
    }
    
    /**
     Performs a query through `queryUsecase` with previously applied parameters.
     */
    private func query() -> AnyPublisher<[IArtAsset], EndpointError> {
        addParameter(currentPage)
        addParameter(resultsPerPage)
        addParameter(currentSearchTerm)
        guard let url = build() else {
            return Fail(error: EndpointError.invalidUrlRequest).eraseToAnyPublisher()
        }
        return queryUsecase.query(url)
    }
    /**
     Requests more data with the previously applied parameters
     */
    public func paginate() -> AnyPublisher<[IArtAsset], EndpointError> {
        guard case let .page(value) = currentPage else {
            return Fail(error: EndpointError.paginationError).eraseToAnyPublisher()
        }
        currentPage = .page(value + 1)
        return query()
    }
    /**
     Performs a fresh search and resets any previous value of `currentPage` & `currentSearchTerm`
     */
    public func search(_ text: String) -> AnyPublisher<[IArtAsset], EndpointError> {
        currentPage = .page(1)
        currentSearchTerm = .searchTerm(text)
        return query()
    }
    public func build() -> URL? {
        return queryManager.build()
    }
}
