import Foundation

enum RequestFetcherError: Error {
    case decodingError(String)
}

class RequestFetcher {
    private var client: HTTPClient
    private var decoder: JSONDecoder?

    let defaultDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()

    let interceptors: [HTTPServiceRequestInterceptor] = [
        InsertTokenInterceptor()
    ]

    init(client: HTTPClient = HTTPClient(), decoder: JSONDecoder? = nil) {
        self.decoder = decoder
        self.client = client
    }

    func fetch<T: Decodable>(_ type: T.Type, request: HTTPRequest) async throws -> T {
        let data = try await client.requestData(request, interceptors: interceptors)

        do {
            let decoder = self.decoder ?? defaultDecoder
            let object = try decoder.decode(type, from: data)
            return object
        } catch {
            let stringType = String(describing: type.self)
            throw RequestFetcherError.decodingError(stringType)
        }
    }
}
