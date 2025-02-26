import Foundation

struct DateFormatView {
    enum Format: String {
        case today = "HH:mm"
        case week = "EEE, HH:mm"
        case moreThanWeek = "dd MMM, HH:mm"
    }

    var referenceDate: Date = Date()
    let startDate: Date?
    let endDate: Date?

    private let calendar = Calendar.current

    var isToday: Bool {
        calendar.isDateInToday(referenceDate)
    }

    var isNow: Bool {
        guard let endDate, let startDate else {
            return false
        }
        return startDate < referenceDate && referenceDate < endDate
    }

    func formattedDate() -> String {
        let calendar = Calendar.current
        let formatter = DateFormatter()

        if isNow {
            return "Agora"
        }

        if isToday {
            formatter.dateFormat = Format.today.rawValue
            return "Hoje, \(formatter.string(from: referenceDate))"
        }

        if let fiveDaysAfter = calendar.date(byAdding: .day, value: 5, to: referenceDate), let startDate {
            if startDate < fiveDaysAfter {
                formatter.dateFormat = Format.week.rawValue
                formatter.locale = Locale(identifier: "pt_BR")
                return formatter.string(from: referenceDate)
            }
        }

        formatter.dateFormat = Format.moreThanWeek.rawValue
        formatter.locale = Locale(identifier: "pt_BR")
        return formatter.string(from: referenceDate)
    }
}
