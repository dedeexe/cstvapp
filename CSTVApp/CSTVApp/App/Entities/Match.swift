import Foundation

struct Match: Identifiable {
    var id: String = UUID().uuidString
    var teams: [Team]
    var league: League
    var serie: Serie
    var beginDate: Date?
    var endDate: Date?

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
}
