import SwiftUI
import AVKit
import AVFoundation

struct CustomVideoPlayerView: UIViewControllerRepresentable {
    var videoUrls: [URL]

    @Binding var currentIndex: Int
    @Binding var isPlaying: Bool

    final class Coordinator {
        var player: AVPlayer

        init(player: AVPlayer) {
            self.player = player
        }

        deinit {
            NotificationCenter.default.removeObserver(self)
        }
    }

    private func addObserver(object: Any, player: AVPlayer) {
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime,
                                               object: object,
                                               queue: .main) { _ in
            resetAndPause(player: player)
        }
    }

    private func resetAndPause(player: AVPlayer) {
        player.seek(to: .zero)
        player.pause()
        isPlaying = false
    }

    func makeCoordinator() -> Coordinator {
        if videoUrls.isEmpty {
            let placeholderUrl = URL(string: "https://example.com/placeholder")!
            return Coordinator(player: AVPlayer(url: placeholderUrl))
        }
        let coordinator = Coordinator(player: AVPlayer(url: videoUrls[currentIndex]))

        if let currentItem = coordinator.player.currentItem {
            addObserver(object: currentItem, player: coordinator.player)
        }
        return coordinator
    }

    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = UIViewController()
        let playerViewController = AVPlayerViewController()
        playerViewController.player = makeCoordinator().player
        playerViewController.showsPlaybackControls = true
        playerViewController.player?.automaticallyWaitsToMinimizeStalling = true

        viewController.addChild(playerViewController)
        viewController.view.addSubview(playerViewController.view)
        playerViewController.view.frame = viewController.view.frame
        playerViewController.didMove(toParent: viewController)

        return viewController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        guard
            let avPlayerViewController = uiViewController.children.first as? AVPlayerViewController,
            let avPlayer = avPlayerViewController.player,
            !videoUrls.isEmpty
        else { return }

        if let currentItem = avPlayer.currentItem,
           let currentUrl = (currentItem.asset as? AVURLAsset)?.url,
           currentUrl != videoUrls[currentIndex] {

            let newPlayerItem = AVPlayerItem(url: videoUrls[currentIndex])
            avPlayer.replaceCurrentItem(with: newPlayerItem)

            NotificationCenter.default.removeObserver(self, name: .AVPlayerItemDidPlayToEndTime, object: avPlayer)

            addObserver(object: newPlayerItem, player: avPlayer)
        }
        isPlaying ? avPlayer.play() : avPlayer.pause()
    }
}
