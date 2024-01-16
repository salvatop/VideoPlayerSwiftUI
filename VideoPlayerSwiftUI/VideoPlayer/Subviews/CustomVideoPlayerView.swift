import SwiftUI
import AVKit
import AVFoundation

struct CustomVideoPlayerView: UIViewControllerRepresentable {
    var videoUrls: [URL]

    @Binding var isPlaying: Bool
    @Binding var currentIndex: Int
    
    final class Coordinator {
        var player: AVPlayer

        init(player: AVPlayer) {
            self.player = player
        }
    }

    func makeCoordinator() -> Coordinator {
        if videoUrls.isEmpty {
            let placeholderUrl = URL(string: "https://example.com/placeholder")!
            return Coordinator(player: AVPlayer(url: placeholderUrl))
        }
        let coordinator = Coordinator(player: AVPlayer(url: videoUrls[0]))
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
        }
        isPlaying ? avPlayer.play() : avPlayer.pause()
    }
}
