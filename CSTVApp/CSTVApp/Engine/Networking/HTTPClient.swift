import Foundation

enum HTTPClientError: Error {
    case invalidRequestURL
    case invalidResponse
    case httpError(Int)
    case serverError(Int)
    case unknownError
    case decodingError(String)
}

protocol HTTPServiceRequestInterceptor {
    var identifier: String { get }
    func intercept(request: URLRequest) -> URLRequest
}

final class HTTPClient {
    let urlSession: URLSession

    private(set) var requestMiddlewares: [HTTPServiceRequestInterceptor] = []

    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }

    func addRequestMiddleware(_ middleware: HTTPServiceRequestInterceptor) {
        requestMiddlewares.append(middleware)
    }

    func requestData(
        _ request: HTTPRequest,
        additionalHeaders: [String: String] = [:],
        interceptors: [HTTPServiceRequestInterceptor]
    ) async throws -> Data {
        let successRange = 200..<300

        guard let urlRequest = makeRequest(request, additionalHeaders: additionalHeaders) else {
            throw HTTPClientError.invalidRequestURL
        }

        let interceptedRequest = interceptors.reduce(urlRequest) { request, middleware in
            middleware.intercept(request: request)
        }

        let (data, response) = try await urlSession.data(for: interceptedRequest)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw HTTPClientError.invalidResponse
        }

        guard case successRange = httpResponse.statusCode else {
            throw HTTPClientError.unknownError
        }

        return data
    }

    private func makeRequest(_ request: HTTPRequest,
                             additionalHeaders: HTTPRequest.Header = [:]) -> URLRequest? {

        guard let url = URL(string: request.url) else { return nil }
        let header = request.header ?? [:]

        var newRequest = URLRequest(url: url,
                                    cachePolicy: URLRequest.CachePolicy.useProtocolCachePolicy,
                                    timeoutInterval: request.timeout)

        newRequest.httpMethod = request.method.rawValue

        header.forEach { key, value in
            newRequest.addValue(value, forHTTPHeaderField: key)
        }

        additionalHeaders.forEach { key, value in
            newRequest.addValue(value, forHTTPHeaderField: key)
        }

        newRequest.httpBody = request.body
        return newRequest
    }
}
