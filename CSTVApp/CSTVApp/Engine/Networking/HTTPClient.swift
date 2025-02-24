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
    let urlCache: URLCache

    private(set) var requestMiddlewares: [HTTPServiceRequestInterceptor] = []

    init(urlSession: URLSession = URLSession.shared, urlCache: URLCache = URLCache.shared) {
        self.urlSession = urlSession
        self.urlCache = urlCache
    }

    func addRequestMiddleware(_ middleware: HTTPServiceRequestInterceptor) {
        requestMiddlewares.append(middleware)
    }

    func requestData(
        _ request: HTTPRequest,
        additionalHeaders: [String: String] = [:],
        interceptors: [HTTPServiceRequestInterceptor],
        useCache: Bool = false
    ) async throws -> Data {
        let successRange = 200..<300

        guard let urlRequest = makeRequest(request, additionalHeaders: additionalHeaders) else {
            throw HTTPClientError.invalidRequestURL
        }


        if useCache, let cachedResponse = urlCache.cachedResponse(for: urlRequest) {
            return cachedResponse.data
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

        urlCache.storeCachedResponse(.init(response: response, data: data), for: urlRequest)
        return data
    }

    private func makeRequest(_ request: HTTPRequest,
                             additionalHeaders: HTTPRequest.Header = [:]) -> URLRequest? {

        guard let transientURL = URL(string: request.url) else {
            return nil
        }

        var urlComponents =  URLComponents(url: transientURL, resolvingAgainstBaseURL: true)
        let queryItems:[URLQueryItem] = request.parameters.map {
            URLQueryItem(name: $0.key, value: $0.value)
        }

        urlComponents?.queryItems = queryItems

        guard let url = urlComponents?.url else {
            return nil
        }

        var newRequest = URLRequest(url: url,
                                    cachePolicy: URLRequest.CachePolicy.useProtocolCachePolicy,
                                    timeoutInterval: request.timeout)

        newRequest.httpMethod = request.method.rawValue

        request.header.forEach { key, value in
            newRequest.addValue(value, forHTTPHeaderField: key)
        }

        additionalHeaders.forEach { key, value in
            newRequest.addValue(value, forHTTPHeaderField: key)
        }

        
        

        return newRequest
    }

}
