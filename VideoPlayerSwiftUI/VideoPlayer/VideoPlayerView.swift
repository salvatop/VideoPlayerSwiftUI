//
//  VideoPlayerView.swift
//  VideoPlayerSwiftUI
//
//  Created by Michael Gauthier on 2021-01-06.
//

import SwiftUI

struct VideoPlayerView: View {
    @EnvironmentObject var viewModel: VideoPlayerViewModel

    @State private var currentIndex: Int = 0
    @State private var isPlaying: Bool = false
    @State private var showControlsOverlay: Bool = true

    var body: some View {
        VStack {
            Text(AppStrings.title)
                .customFont(26)
            if viewModel.isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
            } else {
                ZStack {
                    CustomVideoPlayerView(videoUrls: viewModel.videoUrlList,
                                          currentIndex: $currentIndex,
                                          isPlaying: $isPlaying)
                    .frame(height: 220)
                    .onTapGesture {
                        showControlsOverlay = true
                        Timer.scheduledTimer(withTimeInterval: 6.0, repeats: false) { _ in
                            if isPlaying { showControlsOverlay = false }
                        }
                    }
                    if showControlsOverlay {
                        VideoPlayerControlsView(currentIndex: $currentIndex,
                                                isPlaying: $isPlaying,
                                                showControlsOverlay: $showControlsOverlay,
                                                videoUrlList: viewModel.videoUrlList)
                    }
                }
                .edgesIgnoringSafeArea(.all)
                VStack {
                    VideoDetailsView(currentIndex: $currentIndex, videoList: viewModel.videoList)
                }
            }
        }
        .preferredColorScheme(.dark)
    }

    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            VideoPlayerView()
        }
    }
}
