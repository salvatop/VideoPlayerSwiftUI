import SwiftUI

struct VideoPlayerControlsView: View {
    @Binding var currentIndex: Int
    @Binding var isPlaying: Bool
    @Binding var showControlsOverlay: Bool

    var videoUrlList: [URL]

    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    playPrevious()
                }) {
                    ZStack {
                        Circle()
                            .foregroundColor(.white)
                            .frame(width: 50, height: 50)
                        Image(AppStrings.previous)
                            .accessibility(label: Text(AppStrings.previous))
                    }
                }
                .disabled(currentIndex == 0)
                Button(action: {
                    isPlaying.toggle()
                    if isPlaying {  showControlsOverlay = false }
                }) {
                    ZStack {
                        Circle()
                            .foregroundColor(.white)
                            .frame(width: 70, height: 70)
                        Image(isPlaying ? AppStrings.pause : AppStrings.play)
                            .accessibility(label: Text(AppStrings.playPauseAccessebilityLabel))
                    }
                }
                .padding()
                Button(action: {
                    playNext()
                }) {
                    ZStack {
                        Circle()
                            .foregroundColor(.white)
                            .frame(width: 50, height: 50)
                        Image(AppStrings.next)
                            .accessibility(label: Text(AppStrings.next))
                    }
                }
                .disabled(currentIndex == videoUrlList.count - 1)
            }
            .foregroundColor(.white)
        }
    }

    private func playNext() {
        currentIndex = min(currentIndex + 1, videoUrlList.count - 1)
        isPlaying = true
    }

    private func playPrevious() {
        currentIndex = max(currentIndex - 1, 0)
        isPlaying = true
    }
}
