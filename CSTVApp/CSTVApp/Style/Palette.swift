import SwiftUI

enum Palette: String {
    case background
    case primary
    case secondary
    case caption
    case subtitle

    var color: Color {
        Color(self.rawValue)
    }
}
