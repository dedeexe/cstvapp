

import Foundation

final class TeamService {
    private let path = "teams/"
    let fetcher: RequestFetcher

    init(fetcher: RequestFetcher = RequestFetcher()) {
        self.fetcher = fetcher
    }

    func fetchTeam(id: String) async throws -> PandasScoreResponse.Team {
        let request = HTTPRequest.builder
            .url(ConfigProvider().baseURLFor(game: .none) + path + id)
            .build()

        let result = try await fetcher.fetch(PandasScoreResponse.Team.self, request: request)
        return result
    }
}
