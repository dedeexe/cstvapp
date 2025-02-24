import SwiftUI

enum Palette: String {
    case background
    case caption
    case labelActive
    case labelDeactive
    case primary
    case secondary
    case separator
    case subtitle

    var color: Color {
        Color(self.rawValue)
    }
}
