import SwiftUI

struct TeamNameView: View {
    let name: String
    let imageUrl: URL?

    var body: some View {
        VStack(spacing: Spacing.small) {
            ImageView(imageURL: imageUrl)
                .frame(height: Dimension.raw60)

            Text(name)
                .foregroundStyle(Palette.caption.color)
                .font(Typography.captionSmall)
        }
        .frame(width: Dimension.raw60)
        .padding(Spacing.small)
    }
}

#Preview {
    HStack {
        TeamNameView(name: "First", imageUrl: URL(string: "https://cdn.cdkitchen.com/recipes/images/2016/10/35608-6893-mx.jpg"))
        TeamNameView(name: "Second", imageUrl: nil)
    }
    .background(Palette.background.color)
}
