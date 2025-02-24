extension Serie {
    init?(mapping entity: Response.Serie?) {
        guard let entity = entity else {
            return nil
        }

        self.init(fullName: entity.fullName ?? "")
    }
}
