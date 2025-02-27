import Foundation

class CSGOMatchDetailUseCase {
    enum UseCaseError: Error {
        case missingOpponents
        case parsingMatch
        case generic
    }

    let matchesService: MatchesService
    let teamServices: TeamService

    init(matchesServices: MatchesService = MatchesService(), teamService: TeamService = TeamService()) {
        self.matchesService = matchesServices
        self.teamServices = teamService
    }

    func getMatch(id: Int) async throws -> Match {
        let responseMatch = try await matchesService.fetchMatch(id: id)

        guard let match = Match(mapping: responseMatch) else {
            // TODO: Some log should be done here. Then propagate the error to higher levels
            throw UseCaseError.parsingMatch
        }

        guard match.teams.count > 1 else {
            // TODO: Some log should be done here. Then propagate the error to higher levels
            throw UseCaseError.missingOpponents
        }

        async let firstTeamRequest = teamServices.fetchTeam(id: match.teams[0].id)
        async let secondTeamRequest = teamServices.fetchTeam(id: match.teams[1].id)

        do {
            let (firstTeamResponse, secondTeamResponse) = try await (firstTeamRequest, secondTeamRequest)
            let firstTeam = Team(mapping: firstTeamResponse)
            let secondTeam = Team(mapping: secondTeamResponse)

            var changedMatch = match
            changedMatch.teams[0] = firstTeam
            changedMatch.teams[1] = secondTeam

            return changedMatch
        } catch {
            // TODO: Some log should be done here. Then propagate the error to higher levels
            throw UseCaseError.generic
        }
    }
}
