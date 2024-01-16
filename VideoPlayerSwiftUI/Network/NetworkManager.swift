import Foundation

protocol NetworkManagerProtocol {
    func sendHTTPRequest(urlString: String,
                         dataModel: Decodable.Type) async throws -> Result<[Video], NetworkManager.ApiError>
}


final class NetworkManager: NetworkManagerProtocol {
    enum ApiError: Error {
        case requestError
        case parsingError
        case responseError
        case serverError(code: Int)
        case unknownError
    }

    func makeRequest(from urlString: String) throws -> URLRequest {

        guard let safeUrlString = urlString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed),
              let url = URL(string: safeUrlString) else {
            throw ApiError.requestError
        }
        return URLRequest(url: url)
    }

    func sendHTTPRequest(urlString: String, dataModel: Decodable.Type) async throws -> Result<[Video], ApiError> {

        let request = try makeRequest(from: urlString)

        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let response = response as? HTTPURLResponse else { return .failure(.responseError) }

            switch response.statusCode {
                case 200...299:
                    guard let decodedResponse = try? JSONDecoder().decode(dataModel, from: data) else {
                        return .failure(.parsingError)
                    }
                    return .success(decodedResponse as! [Video])
                default: return .failure(.serverError(code: response.statusCode))
            }
        } catch {
            return .failure(.unknownError)
        }
    }
}
