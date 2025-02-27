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

    private let calendar: Calendar
    private let locale: Locale

    var isToday: Bool {
        if let startDate {
            return calendar.isDateInToday(startDate)
        }
        return false
    }

    var isNow: Bool {
        match.status == .running
    }

    init(
        match: Match,
        referenceDate: Date = Date(),
        calendar: Calendar = .current,
        locale: Locale = .current
    ) {
        self.match = match
        self.referenceDate = referenceDate.normalized() ?? Date()
        self.startDate = match.beginDate?.normalized()
        self.endDate = match.endDate?.normalized()
        self.calendar = calendar
        self.locale = locale
    }

    func formattedDate() -> String {
        let calendar = calendar
        let formatter = DateFormatter()
        formatter.locale = locale

        if isNow {
            return L10n.General.now.localized
        }

        if isToday {
            formatter.dateFormat = Format.today.rawValue
            return L10n.General.today.localized + ", \(formatter.string(from: startDate ?? Date()))"
        }

        if let fiveDaysAfter = calendar.date(byAdding: .day, value: 5, to: referenceDate), let startDate {
            if startDate < fiveDaysAfter {
                formatter.dateFormat = Format.week.rawValue
                return formatter.string(from: startDate)
            }
        }

        formatter.dateFormat = Format.moreThanWeek.rawValue
        return formatter.string(from: startDate ?? Date())
    }
}
