import Foundation

protocol LocalizableEnum {
    var localized: String { get }
}

extension LocalizableEnum where Self: RawRepresentable, Self.RawValue == String {
    var localized: String { String(localized: .init(self.rawValue)) }
}

enum L10n { }


