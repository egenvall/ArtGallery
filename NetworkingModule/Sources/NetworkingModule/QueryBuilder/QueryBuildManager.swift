import Foundation
/**
 Aids in constructing a Query
 */
final class QueryBuildManager {
    private var query: IQuery
    private let baseComponents: String
    init(_ baseComponents: String) {
        self.baseComponents = baseComponents
        self.query = Query(baseComponents)
    }
    func addParameter(_ queryItem: URLQueryItem) {
        query.add(queryItem)
    }
    func build() -> URL? {
        let result = query.resolve()
        query = Query(baseComponents)
        return result
    }
}
