import Foundation

class CSGOMatchDetailUseCase {
    enum UseCaseError: Error {
        case missingOpponents
        case parsingMatch
        case parsingTeam
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
            throw UseCaseError.parsingMatch
        }

        guard match.teams.count > 1 else {
            throw UseCaseError.missingOpponents
        }

        async let firstTeamRequest = teamServices.fetchTeam(id: match.teams[0].id)
        async let secondTeamRequest = teamServices.fetchTeam(id: match.teams[1].id)

        let (firstTeamResponse, secondTeamResponse) = try await (firstTeamRequest, secondTeamRequest)

        guard let firstTeam = Team(mapping: firstTeamResponse), let secondTeam = Team(mapping: secondTeamResponse) else {
            throw UseCaseError.parsingTeam
        }

        var changedMatch = match
        changedMatch.teams[0] = firstTeam
        changedMatch.teams[1] = secondTeam

        return changedMatch
    }
}
