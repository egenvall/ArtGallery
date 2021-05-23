//
//  ArtGalleryApp.swift
//  ArtGallery
//
//  Created by Kim Egenvall on 2021-05-23.
//

import SwiftUI

@main
struct ArtGalleryApp: App {
    private let factory = AppViewFactory()
    var body: some Scene {
        WindowGroup {
            factory.build(.gallery)
        }
    }
}
