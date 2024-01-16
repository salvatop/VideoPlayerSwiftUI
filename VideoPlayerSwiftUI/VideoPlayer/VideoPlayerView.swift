//
//  VideoPlayerView.swift
//  VideoPlayerSwiftUI
//
//  Created by Michael Gauthier on 2021-01-06.
//

import SwiftUI

struct VideoPlayerView: View {
    @EnvironmentObject var viewModel: VideoPlayerViewModel


    var body: some View {
        VStack {
            Text("Video Player")
                .font(.title)
            if viewModel.isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
            } else {
                ZStack {
                    CustomVideoPlayerView(videoUrls: viewModel.videoUrlList)
                    .frame(height: 220)
                }
                .edgesIgnoringSafeArea(.all)
                VStack {
                    VideoDetailsView(videoList: viewModel.videoUrlList)
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
