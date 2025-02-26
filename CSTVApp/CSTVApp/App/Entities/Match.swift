import Foundation

struct Match: Identifiable {
    var id: String
    var teams: [Team]
    var league: League
    var serie: Serie
    var beginDate: Date?
    var endDate: Date?
    var status: Status

    var isRunning: Bool {
        guard let beginDate, let endDate else {
            return false
        }
        
        let now = Date()
        return beginDate < now && now < endDate
    }

    var formattedDate: String {
        if isRunning {
            return "now"
        }

        return "Date"
    }

    var leagueFullName: String {
        var result = league.name

        if !serie.fullName.isEmpty {
            result += " - " + serie.fullName
        }

        return result
    }

    enum Status: String {
        case finished
        case notPlayed = "not_played"
        case notStarted = "not_started"
        case running
        case undefined
    }
}

extension Match {
    static var empty: Match {
        Match(
            id: "",
            teams: [.empty, .empty],
            league: .init(name: ""),
            serie: .init(fullName: ""),
            beginDate: nil,
            endDate: nil,
            status: .undefined
        )
    }
}
