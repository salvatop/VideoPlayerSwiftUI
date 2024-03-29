import Foundation
import OSLog


final class VideoPlayerViewModel: ObservableObject {
    private var networkManager: NetworkManagerProtocol

    @Published var videoList: [Video] = []
    @Published var videoUrlList: [URL] = []
    @Published var isLoading: Bool = false

    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
        fetchData()
    }

    private func sendRequest(endpoint: String) async throws -> Result<[Video], NetworkManager.ApiError> {
        return try await networkManager.sendHTTPRequest(urlString: endpoint, dataModel: [Video].self)
    }

    func fetchData() {
        isLoading = true
        Task(priority: .medium) {
            do {
                let endpoint = Endpoint.videos.url
                let response = try await sendRequest(endpoint: endpoint)

                switch response {
                    case .success(let videos):
                        handleSuccessResponse(videos: videos)
                    case .failure(let error):
                        handleFailureResponse(error: error)
                }
            } catch {
                handleFailureResponse(error: error)
            }
        }
    }

    private func handleSuccessResponse(videos: [Video]) {
        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self else { return }

            let sortedVideos = videos.sorted { $0.publishedAt < $1.publishedAt }

            let videoURLs = sortedVideos.compactMap { URL(string: $0.hlsURL) }

            strongSelf.videoList = sortedVideos
            strongSelf.videoUrlList = videoURLs
            strongSelf.isLoading = false
        }
    }

    private func handleFailureResponse(error: Error) {
        DispatchQueue.main.async { [weak self] in
            self?.isLoading = false
        }
        Logger.network.log("Fetch data request failed: \(error.localizedDescription)")
    }
}
