//
//  ArtGalleryApp.swift
//  ArtGallery
//
//  Created by Kim Egenvall on 2021-05-23.
//

import SwiftUI

@main
struct ArtGalleryApp: App {
    var body: some Scene {
        WindowGroup {
            GalleryView(viewModel: GalleryViewModel())
        }
    }
}
