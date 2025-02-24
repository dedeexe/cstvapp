import Foundation

extension Match {
    init?(mapping entity: Response.Match?) {
        guard let entity = entity else {
            return nil
        }

        guard let league = League(mapping: entity.league),
              let serie = Serie(mapping: entity.serie)
        else {
            return nil
        }

        let opponents = (entity.opponents ?? []).compactMap(Team.init(mapping:))
        guard opponents.count > 1 else {
            return nil
        }

        self.init(
            id: String(entity.id ?? 0),
            teams: opponents,
            league: league,
            serie: serie,
            beginDate: Date(fromISO8601: entity.beginAt ?? ""),
            endDate: Date(fromISO8601: entity.endAt ?? "")
        )
    }
}

