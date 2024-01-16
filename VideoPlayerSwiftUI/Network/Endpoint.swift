import Foundation

enum Endpoint: String {

    private var baseURL: String { return "http://localhost:4000" }

    case videos

    var url: String {
        var path: String

        switch self {
            case .videos: path = "/videos"
        }

        return baseURL + path
    }
}
