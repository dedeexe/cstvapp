import Foundation

extension Team {
    init(mapping entity: PandasScoreResponse.TeamInfo?) {
        self.init(mapping: entity?.opponent)
    }

    init(mapping entity: PandasScoreResponse.Team?) {
        let players = (entity?.players ?? []).map(Player.init(mapping:))
        var teamId = ""

        if let id = entity?.id {
            teamId = String(id)
        }

        self.init(
            id: teamId,
            name: entity?.name ?? "",
            imageURL: URL(string: entity?.imageUrl ?? ""),
            players: players
        )
    }

}
