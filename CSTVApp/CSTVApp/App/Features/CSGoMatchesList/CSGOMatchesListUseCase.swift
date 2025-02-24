import Foundation

class CSGOMatchesListUseCase {
    let service: MatchesService

    init(services: MatchesService = MatchesService()) {
        self.service = services
    }

    func getMatches(beginDate: Date, page: Int) async throws -> [Match] {
        let result = try await service.fetchMatches(beginningAt: beginDate, page: page)
        let matches = result.compactMap(Match.init(mapping:))
        return matches
    }
}
