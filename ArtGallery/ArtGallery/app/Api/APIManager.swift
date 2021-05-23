import Foundation
protocol IAPIManager {
    /// The (authorized) base url for an `api`
    func base(for api: API) -> String
}
struct APIManager: IAPIManager {
    private let keyPath = "API_KEY"
    
    func base(for api: API) -> String {
        return baseUrl(api) + "?key=\(token(for: api))"
    }
    private func token(for api: API) -> String {
        guard let path = Bundle.main.path(forResource: api.rawValue, ofType: "plist") else {
            preconditionFailure("Could not locate \(api.rawValue).plist")
        }
        guard let key = NSDictionary(contentsOfFile: path)?.object(forKey: keyPath) as? String else {
            preconditionFailure("Could find \(keyPath) in \(api.rawValue).plist")
        }
        return key
    }
    private func baseUrl(_ api: API) -> String {
        switch api {
        case .rijksMuseum:
            return "https://www.rijksmuseum.nl/api/en/collection"
        }
    }
}
