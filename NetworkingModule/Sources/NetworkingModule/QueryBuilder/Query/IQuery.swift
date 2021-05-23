import Foundation
protocol IQuery: AnyObject {
    func add(_ component: URLQueryItem)
    func resolve() -> URL?
}
