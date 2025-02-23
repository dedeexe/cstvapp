import Foundation
extension Date {
    var formattedISO8601: String {
        let formatter = ISO8601DateFormatter()
        formatter.timeZone = Locale.current.timeZone
        return formatter.string(from: self)
    }
}


