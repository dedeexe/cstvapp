

import Foundation

final class TeamService {
    private let path = "teams/"
    let fetcher: RequestFetcher

    init(fetcher: RequestFetcher = RequestFetcher()) {
        self.fetcher = fetcher
    }

    func fetchTeam(id: Int) async throws -> Response.Matches {
        let request = HTTPRequest.builder
            .url(ConfigProvider().baseURLFor(game: .csgo) + path + String(id))
            .build()

        let result = try await fetcher.fetch(Response.Matches.self, request: request)
        return result
    }
}
