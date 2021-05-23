import SwiftUI
/**
 A Generic ViewFactory which we can use to hide dependency injection and implementation details from caller location
 */
protocol ViewFactory {
    associatedtype Content: View
    func build() -> Content
}
