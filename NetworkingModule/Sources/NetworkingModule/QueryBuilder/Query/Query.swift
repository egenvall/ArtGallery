import Foundation
final class Query: IQuery {
    private var components: URLComponents?
    init(_ base: String) {
        components = URLComponents(string: base)
    }
    func add(_ component: URLQueryItem) {
        components?.queryItems?.append(component)
    }
    func resolve() -> URL? {
        return components?.url
    }
}
