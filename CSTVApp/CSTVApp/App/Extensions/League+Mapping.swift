import Foundation

extension League {
    init?(mapping entity: Response.League?) {
        guard let entity = entity else {
            return nil
        }

        self.init(
            name: entity.name ?? "",
            imageURL: URL(string: entity.imageUrl ?? "")
        )
    }
}

