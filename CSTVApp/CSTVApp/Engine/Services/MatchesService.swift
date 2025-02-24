import Foundation

final class MatchesService {
    private let path = "matches"
    let fetcher: RequestFetcher

    init(fetcher: RequestFetcher = RequestFetcher()) {
        self.fetcher = fetcher
    }

    func fetchMatches(beginningAt date: Date, page: Int, pageSize: Int = 30) async throws -> Response.Matches {
        let request = HTTPRequest.builder
            .url(ConfigProvider().baseURLFor(game: .csgo) + path)
            .paramter(key: "begin_at", value: date.formattedISO8601)
            .paramter(key: "page", value: String(page))
            .paramter(key: "per_page", value: String(pageSize))
            .paramter(key: "sort", value: "-begin_at")
            .build()

        let result = try await fetcher.fetch(Response.Matches.self, request: request)
        return result
    }
}
