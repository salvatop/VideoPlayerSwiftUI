//
//  ContentView.swift
//  VideoPlayerSwiftUI
//
//  Created by Michael Gauthier on 2021-01-06.
//

import SwiftUI
import AVKit

struct VideoPlayerView: View {
    let videoUrls = [URL(string: "https://d140vvwqovffrf.cloudfront.net/media/5e87b9a811599/hls/index.m3u8")]
    var body: some View {
        VStack {
            Text("Video Player")
                .font(.title)
            ZStack {
                VideoPlayer(player: AVPlayer())
                    .frame(height: 220)
            }
            .edgesIgnoringSafeArea(.all)
            VStack {
                HStack{
                    Text("Description")
                    Spacer()
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
