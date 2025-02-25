import Foundation

extension Team {
    init?(mapping entity: PandasScoreResponse.TeamInfo?) {
        guard let entity = entity else {
            return nil
        }

        self.init(
            name: entity.opponent?.name ?? "",
            imageURL: URL(string: entity.opponent?.imageUrl ?? "")
        )
    }
}
