import SwiftUI

struct TextLabel: View {
    let text: String
    var style: Style

    init(_ text: String, style: Style = .small) {
        self.text = text
        self.style = style
    }

    var body: some View {
        Text(text)
            .font(style.font)
            .foregroundStyle(style.color)
    }
}

// MARK: - Style

extension TextLabel {
    enum Style {
        case small
        case tiny
        case subtitle
        case caption

        var font: Font {
            switch self {
            case .small:
                return Typography.captionSmall
            case .tiny:
                return Typography.captionTiny
            case.subtitle:
                return Typography.subtitle
            case .caption:
                return Typography.caption
            }
        }

        var color: Color {
            switch self {
            case .small, .tiny:
                return Palette.caption.color
            case .subtitle:
                return Palette.subtitle.color
            case .caption:
                return Palette.caption.color
            }
        }
    }
}

#Preview {
    VStack {
        TextLabel("Test of Text")
    }
    .background(Palette.background.color)
}
