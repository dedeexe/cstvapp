import SwiftUI

struct ImageView: View {
    let imageURL: URL?

    var body: some View {
        AsyncImage(url: imageURL) { phase in
            switch phase {
            case .success(let image):
                image
                    .resizable()
                    .scaledToFit()
            case .failure, .empty:
                placeholder
            @unknown default:
                placeholder
            }
        }
    }

    var placeholder: some View {
        Circle()
            .frame(height: Measure.raw60)
            .foregroundStyle(Palette.secondary.color)
    }
}

#Preview {
    HStack {
        ImageView(imageURL: nil)
            .frame(width: 60, height: 60)
        ImageView(imageURL: URL(string: "https://cdn.cdkitchen.com/recipes/images/2016/10/35608-6893-mx.jpg"))
            .frame(width: 60, height: 60)
    }
    .background(Palette.background.color)
}
