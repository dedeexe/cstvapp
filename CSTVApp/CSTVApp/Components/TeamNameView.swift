import SwiftUI

struct TeamNameView: View {
    let name: String
    let imageUrl: URL?

    var body: some View {
        VStack(spacing: Measure.spaceSmall) {
            ImageView(imageURL: imageUrl)
                .frame(height: Measure.raw60)
            
            TextLabel(name, style: .small)
        }
        .frame(width: Measure.raw60)
        .padding(Measure.spaceSmall)
    }
}

#Preview {
    HStack {
        TeamNameView(name: "First", imageUrl: URL(string: "https://cdn.cdkitchen.com/recipes/images/2016/10/35608-6893-mx.jpg"))
        TeamNameView(name: "Second", imageUrl: nil)
    }
    .background(Palette.background.color)
}
