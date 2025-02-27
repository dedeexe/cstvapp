import Foundation

class CSGOMatchDetailScreenViewModel: ObservableObject {

    @Published var match: Match = .empty
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil

    private let useCase: CSGOMatchDetailUseCase
    private let matchId: String
    private let router: CSGOMatchDetailRouter

    var hasError: Bool {
        errorMessage != nil
    }

    var firstTeam: Team {
        match.teams[0]
    }

    var secondTeam: Team {
        match.teams[1]
    }

    var players: [(Player, Player)] {
        normalizedTeams()
    }

    var title: String {
        match.league.name + " " + match.serie.fullName
    }

    var matchDate: String {
        match.formattedDate
    }

    init(matchId: String, useCase: CSGOMatchDetailUseCase = CSGOMatchDetailUseCase(), router: CSGOMatchDetailRouter) {
        self.useCase = useCase
        self.matchId = matchId
        self.router = router
    }

    func getMatchDetail() {
        guard !isLoading, let id = Int(matchId) else {
            return
        }

        errorMessage = nil
        isLoading.toggle()

        Task {
            do {
                let result = try await useCase.getMatch(id: id)

                Task { @MainActor [weak self] in
                    self?.match = result
                    self?.isLoading = false
                }
            } catch {
                Task { @MainActor [weak self] in
                    self?.errorMessage = L10n.ErrorMessage.generic.localized
                    self?.isLoading = false
                }
            }
        }
    }

    func routeBack() {
        router.rootCoordinator.popLast()
    }

    private func normalizedTeams() -> [(Player, Player)] {
        var firstTeamPlayers = firstTeam.players
        var secondTeamPlayers = secondTeam.players

        let difference = firstTeamPlayers.count - secondTeamPlayers.count

        for _ in 0..<abs(difference) {
            if difference < 0 {
                firstTeamPlayers.append(.empty)
                continue
            }

            secondTeamPlayers.append(.empty)
        }

        return Array(zip(firstTeamPlayers, secondTeamPlayers))
    }
}
