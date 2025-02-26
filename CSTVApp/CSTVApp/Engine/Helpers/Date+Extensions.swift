import Foundation
extension Date {
    var formattedISO8601: String {
        let formatter = ISO8601DateFormatter()
        formatter.timeZone = Locale.current.timeZone
        return formatter.string(from: self)
    }

    init?(fromISO8601 dateString: String) {
        let formatter = ISO8601DateFormatter()
        formatter.timeZone = Locale.current.timeZone
        guard let date = formatter.date(from: dateString) else {
            return nil
        }

        self = date
    }

    func normalized(calendar: Calendar = Calendar.current, timezone: TimeZone = TimeZone.current) -> Date? {
        let nowComponents = calendar.dateComponents(in: timezone, from: self)
        let normalizedDate = calendar.date(from: nowComponents)
        return normalizedDate
    }
}


