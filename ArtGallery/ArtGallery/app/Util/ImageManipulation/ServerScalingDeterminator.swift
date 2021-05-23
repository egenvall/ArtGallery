import Foundation
import SwiftUI
/**
 Determines from predefined sources whether we can request scaled images from the server or not.
 */
final class ServerScalingDeterminator {
    private let googleDomains = Set(["lh3.googleusercontent.com", "lh4.googleusercontent.com", "lh5.googleusercontent.com", "lh6.googleusercontent.com","lh3.ggpht.com", "lh4.ggpht.com", "lh5.ggpht.com", "lh6.ggpht.com"])
    func getImageUrlManipulator(_ imageUrl: String) -> ImageUrlManipulator {
        guard let url = URL(string: imageUrl), let host = url.host else {
            return .none
        }
        if googleDomains.contains(host) {
            return .google(GoogleStorageImageUrlManipulator(imageUrl))
        }
        else {
            return .none
        }
    }
}
/*
 This class should have better access control as it shouldnt be instantiated outside of ServerScalingDeterminator
 */
final class GoogleStorageImageUrlManipulator {
    private var urlString: String
    private lazy var components = Set<String>()
    private lazy var scale = Int(UIScreen.main.scale)
    enum Manipulator: String {
        case smartCrop = "p-", size = "s", width = "w", height = "h"
    }
    fileprivate init(_ urlString: String) {
        // Try initial modification, but sequential operations have priority.
        var initialUrl = urlString.replacingOccurrences(of: "=s0", with: "=")
        if let last = initialUrl.last, last != "=" {
            initialUrl.append("=")
        }
        self.urlString = initialUrl
    }
    @discardableResult
    func smartCrop() -> GoogleStorageImageUrlManipulator {
        components.insert(Manipulator.smartCrop.rawValue)
        return self
    }
    @discardableResult
    func size(_ maximumSide: Int) -> GoogleStorageImageUrlManipulator {
        components.insert("\(Manipulator.size.rawValue)\(maximumSide * scale)")
        return self
    }
    @discardableResult
    func size(_ maximumSide: CGFloat) -> GoogleStorageImageUrlManipulator {
        return size(Int(maximumSide))
    }
    @discardableResult
    func height(_ height: Int) -> GoogleStorageImageUrlManipulator {
        components.insert("\(Manipulator.height.rawValue)\(height * scale)")
        return self
    }
    @discardableResult
    func height(_ value: CGFloat) -> GoogleStorageImageUrlManipulator {
        return height(Int(value))
    }
    @discardableResult
    func width(_ width: Int) -> GoogleStorageImageUrlManipulator {
        components.insert("\(Manipulator.width.rawValue)\(width * scale)")
        return self
    }
    @discardableResult
    func width(_ value: CGFloat) -> GoogleStorageImageUrlManipulator {
        return width(Int(value))
    }
    func url() -> URL? {
        let manipulations = components.joined(separator: "-")
        components.removeAll()
        return URL(string: urlString + manipulations)
    }
}

