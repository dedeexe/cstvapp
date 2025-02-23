import Foundation

struct HTTPRequest {
    var url: String
    var method: Method = .get
    var parameters: Parameters = [:]
    var header: Header = [:]
    var body: Body? = nil

    var timeout: TimeInterval = 30.0

    // MARK: - Static Methosd
    static var builder: HTTPRequestBuilder {
        HTTPRequestBuilder()
    }

    // MARK: - Declarations
    typealias Body = Data
    typealias Header = [String: String]
    typealias Parameters = [String: String]

    enum Method: String {
        case get = "GET"
        case post = "POST"
        case put = "PUT"
        case patch = "PATCH"
        case delete = "DELETE"
    }
}

class HTTPRequestBuilder {
    private var request = HTTPRequest(url: "")

    func url(_ value: String) -> HTTPRequestBuilder {
        request.url = value
        return self
    }

    func method(_ value: HTTPRequest.Method) -> HTTPRequestBuilder {
        request.method = value
        return self
    }

    func body(_ value: HTTPRequest.Body?) -> HTTPRequestBuilder {
        request.body = value
        return self
    }

    func header(key: String, value: String?) -> HTTPRequestBuilder {
        request.header[key] = value
        return self
    }

    func paramter(key: String, value: String?) -> HTTPRequestBuilder {
        request.parameters[key] = value
        return self
    }

    func timeout(_ value: TimeInterval) -> HTTPRequestBuilder {
        request.timeout = value
        return self
    }

    func build() -> HTTPRequest{
        request
    }
}
