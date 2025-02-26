import Foundation

extension League {
    init(mapping entity: PandasScoreResponse.League?) {
        self.init(
            name: entity?.name ?? "",
            imageURL: URL(string: entity?.imageUrl ?? "")
        )
    }
}

