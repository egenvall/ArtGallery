//
//  ArtGalleryApp.swift
//  ArtGallery
//
//  Created by Kim Egenvall on 2021-05-23.
//

import SwiftUI

@main
struct ArtGalleryApp: App {
    private let mainFactory = GalleryViewFactory()
    var body: some Scene {
        WindowGroup {
            mainFactory.build()
        }
    }
}
