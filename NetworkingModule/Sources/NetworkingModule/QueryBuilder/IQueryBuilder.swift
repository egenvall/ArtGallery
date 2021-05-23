import Foundation
public protocol IQueryBuilder: AnyObject {
    @discardableResult func addParameter(_ param: QueryParameter) -> IQueryBuilder
    func build() -> URL?
}
