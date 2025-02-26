#if DEBUG
import Foundation

extension Match {
    static func fixture(
        id: String = "1",
        teams: [Team] = [
            .fixture(id: "1", name: "Team A"),
            .fixture(id: "1", name: "Team B")
        ],
        league: League = .fixture(),
        serie: Serie = .fixture(),
        beginDate: Date? = Date(),
        endDate: Date? = Date().addingTimeInterval(3600)
    ) -> Match {
        Match(id: "1", teams: teams, league: .fixture(), serie: serie, beginDate: beginDate, endDate: endDate, status: .undefined)
    }
}
#endif
