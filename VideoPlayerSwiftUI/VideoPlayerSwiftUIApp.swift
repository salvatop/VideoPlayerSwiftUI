//
//  VideoPlayerSwiftUIApp.swift
//  VideoPlayerSwiftUI
//
//  Created by Michael Gauthier on 2021-01-06.
//

import SwiftUI

@main
struct VideoPlayerSwiftUIApp: App {
    var body: some Scene {
        WindowGroup {
            let viewModel = VideoPlayerViewModel(networkManager: NetworkManager())
            VideoPlayerView()
                .environmentObject(viewModel)
        }
    }
}
