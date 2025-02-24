import Foundation

extension Team {
    init?(mapping entity: Response.TeamInfo?) {
        guard let entity = entity else {
            return nil
        }

        self.init(
            name: entity.opponent?.name ?? "",
            imageURL: URL(string: entity.opponent?.imageUrl ?? "")
        )
    }
}
