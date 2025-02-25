import Foundation

extension Team {
    init?(mapping entity: PandasScoreResponse.TeamInfo?) {
        // TODO: REMOVE THIS COMMENTED SNIPPET
//        guard let entity = entity, let teamId = entity.opponent?.id else {
//            return nil
//        }
//
//        let players = entity.opponent?.players?.map(Player.init(mapping:))
//
//        self.init(
//            id: String(teamId),
//            name: entity.opponent?.name ?? "",
//            imageURL: URL(string: entity.opponent?.imageUrl ?? ""),
//            players: players ?? []
//        )

        self.init(mapping: entity?.opponent)
    }

    init?(mapping entity: PandasScoreResponse.Team?) {
        guard let entity = entity, let teamId = entity.id else {
            return nil
        }

        let players = entity.players?.map(Player.init(mapping:))

        self.init(
            id: String(teamId),
            name: entity.name ?? "",
            imageURL: URL(string: entity.imageUrl ?? ""),
            players: players ?? []
        )
    }

}
