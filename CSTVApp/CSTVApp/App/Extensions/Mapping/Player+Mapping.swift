import Foundation

extension Player {
    init(mapping entity: PandasScoreResponse.Player?) {
        var playerId = UUID().uuidString
        var playerName = ""

        if let entityId = entity?.id {
            playerId = String(entityId)
        }

        if let firstName = entity?.firstName {
            playerName = firstName
        }

        if let lastName = entity?.lastName {
            playerName += playerName.isEmpty ? lastName : " " + lastName
        }

        self.init(
            id: playerId,
            name: playerName,
            nickname: entity?.name ?? "",
            imageURL: URL(string: entity?.imageUrl ?? "")
        )
    }
}
