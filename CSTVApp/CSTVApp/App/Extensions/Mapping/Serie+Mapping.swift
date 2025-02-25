extension Serie {
    init?(mapping entity: PandasScoreResponse.Serie?) {
        guard let entity = entity else {
            return nil
        }

        self.init(fullName: entity.fullName ?? "")
    }
}
