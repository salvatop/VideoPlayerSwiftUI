import Foundation

struct Video: Decodable {

    let id: String
    let title: String
    let hlsURL: String
    let fullURL: String
    let description: String
    let publishedAt: String
    let author: Author

    struct Author: Decodable {
        let id: String
        let name: String
    }
}
