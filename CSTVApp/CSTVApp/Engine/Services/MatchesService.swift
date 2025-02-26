import Foundation

final class MatchesService {
    private let path = "matches"
    let fetcher: RequestFetcher

    init(fetcher: RequestFetcher = RequestFetcher()) {
        self.fetcher = fetcher
    }

    func fetchMatches(beginningAt date: Date, page: Int, pageSize: Int = 30) async throws -> PandasScoreResponse.Matches {
        let extraPath = "/running"

        let request = HTTPRequest.builder
            .url(ConfigProvider().baseURLFor(game: .csgo) + path + extraPath)
            .paramter(key: "begin_at", value: date.formattedISO8601)
            .paramter(key: "page", value: String(page))
            .paramter(key: "per_page", value: String(pageSize))
            .paramter(key: "sort", value: "begin_at")
            .build()

        let result = try await fetcher.fetch(PandasScoreResponse.Matches.self, request: request)
        return result
    }

    func fetchMatch(id: Int) async throws -> PandasScoreResponse.Match {
        let request = HTTPRequest.builder
            .url(ConfigProvider().baseURLFor(game: .none) + path + "/" + String(id))
            .build()

        let result = try await fetcher.fetch(PandasScoreResponse.Match.self, request: request)
        return result
    }
}
