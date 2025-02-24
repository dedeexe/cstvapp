import Foundation
import UIKit

enum ImageFetcherError: Error {
    case downloadFail(String)
}

class ImageFetcher {
    private var client: HTTPClient

    init(client: HTTPClient = HTTPClient()) {
        self.client = client
    }

    func fetch(request: HTTPRequest) async throws -> UIImage? {
        do {
            let data = try await client.requestData(request, interceptors: [], useCache: true)

            guard let image = UIImage(data: data) else {
                return nil
            }
            
            return image
        } catch {
            throw ImageFetcherError.downloadFail(error.localizedDescription)
        }
    }
}
