import Foundation

enum ServiceError: Error {
    case generic(String)
}

struct ServiceErrorHandler {
    let error: any Error

    func translateError() -> Error {
        switch error {
        case let HTTPClientError.httpError(statusCode, data):
            let parsedObject = parsePandasStoreError(data: data)
            return ServiceError.generic(parsedObject.error ?? "")
        default:
            return NSError(domain: "Unknown Error", code: 1000)
        }
    }

    private func parsePandasStoreError(data: Data) -> PandasScoreResponse.ErrorResponse {
        let decoder = DefaultJSONDecoder.decoder
        do {
            let object = try decoder.decode(PandasScoreResponse.ErrorResponse.self, from: data)
            return object
        } catch {
            return PandasScoreResponse.ErrorResponse(error: error.localizedDescription)
        }
    }
}


