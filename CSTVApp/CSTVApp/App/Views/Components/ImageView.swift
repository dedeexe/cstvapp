import SwiftUI
import UIKit

struct CachedImageView: View {
    enum Phase {
        case idle
        case loading
        case loaded(UIImage)
        case failed
    }

    enum PlaceholderStyle {
        case roundedRectangle
        case circle
    }

    @State private var phase: Phase = .idle
    let imageURL: URL?
    var aspectFill: Bool = false
    var placeholderStyle: PlaceholderStyle = .circle
    var fetcher: ImageFetcher = ImageFetcher()

    var body: some View {
        Group {
            switch phase {
            case .idle:
                placeholder
                    .onAppear {
                        Task {
                            await self.downloadImage()
                        }
                    }
            case .loading:
                SpinnerView()
            case .loaded(let uiImage):
                if aspectFill {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                } else {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                }
            case .failed:
                placeholder
            }
        }
    }

    var placeholder: some View {
        switch placeholderStyle {
        case .circle:
            return AnyView(Circle()
                .frame(height: Measure.raw60)
                .foregroundStyle(Palette.secondary.color))
        case .roundedRectangle:
            return AnyView(RoundedRectangle(cornerRadius: Measure.radiusXSmall)
                .foregroundStyle(Palette.secondary.color))
        }

    }

    func downloadImage() async {
        phase = .loading

        do {
            guard let result = try await fetcher.fetch(request: HTTPRequest(url: imageURL?.absoluteString ?? "")) else {
                phase = .failed
                return
            }
            phase = .loaded(result)
        } catch {
            phase = .failed
            return
        }
    }
}

#Preview {
    HStack {
        CachedImageView(imageURL: nil)
            .frame(width: 60, height: 60)
        CachedImageView(imageURL: URL(string: "https://cdn.cdkitchen.com/recipes/images/2016/10/35608-6893-mx.jpg"))
            .frame(width: 60, height: 60)
        CachedImageView(imageURL: nil, placeholderStyle: .roundedRectangle)
            .frame(width: 60, height: 60)
    }
    .background(Palette.background.color)
}
