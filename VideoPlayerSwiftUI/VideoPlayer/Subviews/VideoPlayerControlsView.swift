import SwiftUI

struct VideoPlayerControlsView: View {

    @Binding var isPlaying: Bool
    @Binding var showControlsOverlay: Bool

    var videoUrlList: [URL]

    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    isPlaying.toggle()
                    if isPlaying {  showControlsOverlay = false }
                }) {
                    ZStack {
                        Circle()
                            .foregroundColor(.white)
                            .frame(width: 70, height: 70)
                        Image(isPlaying ? "pause" : "play")
                    }
                }
                .padding()
            }
            .foregroundColor(.white)
        }
    }
}
