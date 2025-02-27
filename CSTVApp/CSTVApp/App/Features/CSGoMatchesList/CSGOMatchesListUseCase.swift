import Foundation

class CSGOMatchesListUseCase {
    enum UseCaseError: Error {
        case generic
    }

    let service: MatchesService

    init(services: MatchesService = MatchesService()) {
        self.service = services
    }

    func getMatches(beginDate: Date, page: Int) async throws -> [Match] {
        do {
            let result = try await service.fetchMatches(beginningAt: beginDate, page: page)
            let matches = result.compactMap(Match.init(mapping:))
            return matches
        } catch {
           // TODO: Some log should be done here. Then propagate the error to higher levels
           throw UseCaseError.generic
       }
    }
}
