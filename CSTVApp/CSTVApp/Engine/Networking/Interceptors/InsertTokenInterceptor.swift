import Foundation

struct InsertTokenInterceptor: HTTPServiceRequestInterceptor {
    var identifier: String = "InsertTokenInterceptor"
    
    func intercept(request: URLRequest) -> URLRequest {
        var newRequest = request
        newRequest.addValue("Bearer " + SecretProvider.token, forHTTPHeaderField: "Authorization")
        return newRequest
    }
}
