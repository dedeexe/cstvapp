import Foundation

struct Match: Identifiable {
    var id: String
    var teams: [Team]
    var league: League
    var serie: Serie
    var beginDate: Date?
    var endDate: Date?
    var status: Status
}

extension Match {
    var isRunning: Bool {
        status == .running
    }

    var formattedDate: String {
        if isRunning {
            return L10n.General.now.localized
        }

        return DateFormatView(match: self).formattedDate()
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
