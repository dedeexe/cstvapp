import Foundation

class CSGOMatchesListUseCase {
    enum UseCaseError: Error {
        case generic
        case notMoreResults
    }

    let service: MatchesService
    var currentSchedule = MatchesService.ScheduleType.running
    var pageOffset = 0

    private let firstPage = 1

    init(services: MatchesService = MatchesService()) {
        self.service = services
    }

    func getMatches(beginDate: Date, page: Int) async throws -> [Match] {
        if page == firstPage {
            pageOffset = 0
            currentSchedule = .running
        }

        do {
            var result = try await service.fetchMatches(schedule: currentSchedule, beginningAt: beginDate, page: page - pageOffset)

            if result.isEmpty && currentSchedule == .running{
                pageOffset = max(0, page - 1)
                currentSchedule = .upcoming
                result = try await service.fetchMatches(schedule: currentSchedule, beginningAt: beginDate, page: page - pageOffset)
            }

            guard !result.isEmpty else {
                throw UseCaseError.notMoreResults
            }

            let matches = result.compactMap(Match.init(mapping:))
            return matches
        } catch {
            // TODO: Some log should be done here. Then propagate the error to higher levels
            throw hangleError(error: error)
       }
    }

    func hangleError(error: Error) -> Error {
        switch error {
        case UseCaseError.notMoreResults:
            return UseCaseError.notMoreResults

        default:
            return UseCaseError.generic
        }
    }
}
