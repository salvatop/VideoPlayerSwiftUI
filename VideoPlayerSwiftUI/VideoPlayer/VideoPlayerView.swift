//
//  ContentView.swift
//  VideoPlayerSwiftUI
//
//  Created by Michael Gauthier on 2021-01-06.
//

import SwiftUI
import AVKit

struct VideoPlayerView: View {
    @EnvironmentObject var viewModel: VideoPlayerViewModel
    
    var body: some View {
        VStack {
            Text("Video Player")
                .font(.title)
            ZStack {
                CustomVideoPlayerView(videoUrls: viewModel.videoUrlList)
                    .frame(height: 220)
            }
            .edgesIgnoringSafeArea(.all)
            VStack {
                HStack{
                    ScrollView {
                        VideoDetailsView(videoList: viewModel.videoUrlList)
                        Spacer()
                    }
                    .background(Color.white)
                }
                .padding()
                Spacer()
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
