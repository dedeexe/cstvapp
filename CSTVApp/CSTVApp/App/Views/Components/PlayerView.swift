import SwiftUI

struct PlayerView: View {
    enum Style {
        case leading
        case trailing
    }

    let player: Player
    let style: Style

    var body: some View {
        ZStack(alignment: style == .leading ? .leading : .trailing) {
            HStack {
                if style == .trailing {
                    Spacer()
                }

                VStack(alignment: horizontalAlignment) {
                    TextLabel(player.nickname, style: .caption)
                    TextLabel(player.name, style: .subtitle)
                }
                .padding(style == .leading ? .leading : .trailing, 72)

                if style == .leading {
                    Spacer()
                }
            }
            .frame(height: Measure.raw54)
            .frame(maxWidth: .infinity)
            .background(Palette.primary.color)
            .clipShape(clipShapeStyle)
            .padding(.top, 8)

            photoView
                .padding(.top, -8)
        }
    }

    var clipShapeStyle: UnevenRoundedRectangle {
        let radius = Measure.radiusXSmall

        switch style {
        case .trailing:
            return UnevenRoundedRectangle.rect(bottomTrailingRadius: radius, topTrailingRadius: radius)
        case .leading:
            return UnevenRoundedRectangle.rect(topLeadingRadius: radius, bottomLeadingRadius: radius)
        }
    }

    var horizontalAlignment: HorizontalAlignment {
        switch style {
        case .trailing:
            return .trailing
        case .leading:
            return .leading
        }
    }

    var photoView: some View {
        CachedImageView(imageURL: player.imageURL, aspectFill: true, placeholderStyle: .roundedRectangle)
            .frame(width: Measure.raw48, height: Measure.raw48)
            .clipShape(RoundedRectangle(cornerRadius: Measure.radiusXSmall))
            .padding(style == .leading ? .leading : .trailing, Measure.raw8)
    }
}

#Preview {
    VStack(spacing: 16) {
        Spacer()
        PlayerView(player: Player(id: "0", name: "Player", nickname: "Mr Player", imageURL: URL(string: "https://cdn.cdkitchen.com/recipes/images/2016/10/35608-6893-mx.jpg")), style: .leading)
            .padding(.leading, 30)

        PlayerView(player: Player(id: "1", name: "Player", nickname: "Mr Player", imageURL: URL(string: "https://cdn.cdkitchen.com/recipes/images/2016/10/35608-6893-mx.jpg")), style: .trailing)
            .padding(.trailing, 30)
        Spacer()
    }
    .background(Palette.background.color)
}
