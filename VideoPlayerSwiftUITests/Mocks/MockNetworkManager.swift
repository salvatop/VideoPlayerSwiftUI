import Foundation

final class MockNetworkManager: NetworkManagerProtocol {
    var sendRequestResult: Result<[Video], NetworkManager.ApiError>?

    func sendHTTPRequest(urlString: String, dataModel: Decodable.Type) async throws -> Result<[Video], NetworkManager.ApiError> {
        guard let result = sendRequestResult else {
            throw NetworkManager.ApiError.unknownError
        }
        return result
    }
}
