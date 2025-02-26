extension Serie {
    init(mapping entity: PandasScoreResponse.Serie?) {
        self.init(fullName: entity?.fullName ?? "")
    }
}
