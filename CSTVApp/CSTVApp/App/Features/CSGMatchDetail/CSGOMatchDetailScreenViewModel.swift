import Foundation

class CSGOMatchDetailScreenViewModel: ObservableObject {

    @Published var match: Match = .empty
    @Published var isLoading: Bool = false

    let useCase: CSGOMatchDetailUseCase
    let matchId: String

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

    init(matchId: String = "1131797", useCase: CSGOMatchDetailUseCase = CSGOMatchDetailUseCase()) {
        self.useCase = useCase
        self.matchId = matchId

//        self.match = Match(
//            id: UUID().uuidString,
//            teams: [
//                .init(
//                    id: UUID().uuidString,
//                    name: "Team1",
//                    imageURL: URL(string: "https://cdn.cdkitchen.com/recipes/images/2016/10/35608-6893-mx.jpg"),
//                    players: [
//                        .init(id: UUID().uuidString, name: "Player1", nickname: "player_1", imageURL: URL(string:"https://cdn.cdkitchen.com/recipes/images/2016/10/35608-6893-mx.jpg")),
//                        .init(id: UUID().uuidString, name: "Player2", nickname: "player_2", imageURL: URL(string:"https://cdn.cdkitchen.com/recipes/images/2016/10/35608-6893-mx.jpg")),
//                        .init(id: UUID().uuidString, name: "Player3", nickname: "player_3", imageURL: URL(string:"https://cdn.cdkitchen.com/recipes/images/2016/10/35608-6893-mx.jpg")),
//                        .init(id: UUID().uuidString, name: "Player4", nickname: "player_4", imageURL: URL(string:"https://cdn.cdkitchen.com/recipes/images/2016/10/35608-6893-mx.jpg")),
//                        .init(id: UUID().uuidString, name: "Player5", nickname: "player_5", imageURL: URL(string:"https://cdn.cdkitchen.com/recipes/images/2016/10/35608-6893-mx.jpg"))
//                    ]
//                ),
//                .init(
//                    id: UUID().uuidString,
//                    name: "Team1",
//                    imageURL: URL(string: "https://cdn.cdkitchen.com/recipes/images/2016/10/35608-6893-mx.jpg"),
//                    players: [
//                        .init(id: UUID().uuidString, name: "Player1", nickname: "player_1", imageURL: URL(string:"https://cdn.cdkitchen.com/recipes/images/2016/10/35608-6893-mx.jpg")),
//                        .init(id: UUID().uuidString, name: "Player2", nickname: "player_2", imageURL: URL(string:"https://cdn.cdkitchen.com/recipes/images/2016/10/35608-6893-mx.jpg")),
//                        .init(id: UUID().uuidString, name: "Player3", nickname: "player_3", imageURL: URL(string:"https://cdn.cdkitchen.com/recipes/images/2016/10/35608-6893-mx.jpg")),
//                        .init(id: UUID().uuidString, name: "Player4", nickname: "player_4", imageURL: URL(string:"https://cdn.cdkitchen.com/recipes/images/2016/10/35608-6893-mx.jpg")),
//                        .init(id: UUID().uuidString, name: "Player5", nickname: "player_5", imageURL: URL(string:"https://cdn.cdkitchen.com/recipes/images/2016/10/35608-6893-mx.jpg"))
//                    ]
//                )
//            ],
//            league: .init(name: "The League", imageURL: URL(string:"https://cdn.cdkitchen.com/recipes/images/2016/10/35608-6893-mx.jpg")),
//            serie: .init(fullName: "The Serie")
//        )
    }

    func getMatchDetail() {
        guard !isLoading, let id = Int(matchId) else {
            return
        }

        isLoading.toggle()

        Task {
            let result = try await useCase.getMatch(id: id)

            Task { @MainActor [weak self] in
                self?.match = result
                self?.isLoading = false
            }
        }
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
