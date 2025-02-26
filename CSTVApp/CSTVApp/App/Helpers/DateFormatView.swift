import Foundation

struct DateFormatView {
    enum Format: String {
        case today = "HH:mm"
        case week = "EEE, HH:mm"
        case moreThanWeek = "dd MMM, HH:mm"
    }

    var match: Match
    var referenceDate: Date = Date()
    private let startDate: Date?
    private let endDate: Date?

    private let calendar = Calendar.current
    private let timezone = TimeZone.current

    var isToday: Bool {
        if let startDate {
            return calendar.isDateInToday(startDate)
        }
        return false
    }

    var isNow: Bool {
        match.status == .running
    }

    init(match: Match, referenceDate: Date = Date()) {
        self.match = match
        self.referenceDate = referenceDate.normalized() ?? Date()
        self.startDate = match.beginDate?.normalized()
        self.endDate = match.endDate?.normalized()
    }

    func formattedDate() -> String {
        let calendar = Calendar.current
        let formatter = DateFormatter()

        if isNow {
            return "Agora"
        }

        if isToday {
            formatter.dateFormat = Format.today.rawValue
            return "Hoje, \(formatter.string(from: startDate ?? Date()))"
        }

        if let fiveDaysAfter = calendar.date(byAdding: .day, value: 5, to: referenceDate), let startDate {
            if startDate < fiveDaysAfter {
                formatter.dateFormat = Format.week.rawValue
                formatter.locale = Locale(identifier: "pt_BR")
                return formatter.string(from: startDate)
            }
        }

        formatter.dateFormat = Format.moreThanWeek.rawValue
        formatter.locale = Locale(identifier: "pt_BR")
        return formatter.string(from: startDate ?? Date())
    }
}
