import Foundation

extension Match {
    init?(mapping entity: PandasScoreResponse.Match?) {
        let opponents = (entity?.opponents ?? []).compactMap(Team.init(mapping:))

        guard opponents.count == 2 else {
            return nil
        }

        self.init(
            id: String(parsingId: entity?.id),
            teams: opponents,
            league: League(mapping: entity?.league),
            serie: Serie(mapping: entity?.serie),
            beginDate: Date(fromISO8601: entity?.beginAt ?? ""),
            endDate: Date(fromISO8601: entity?.endAt ?? ""),
            status: Status(rawValue: entity?.status ?? "") ?? .undefined
        )
    }
}

