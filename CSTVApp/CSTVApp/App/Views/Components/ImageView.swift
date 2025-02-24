import SwiftUI
import UIKit

struct CachedImageView: View {
    enum Phase {
        case idle
        case loading
        case loaded(UIImage)
        case failed
    }

    @State var phase: Phase = .idle
    let imageURL: URL?
    var scalling: Bool = false
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
                Text("Loading...")
            case .loaded(let uiImage):
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
            case .failed:
                placeholder
            }
        }
    }

    var placeholder: some View {
        Circle()
            .frame(height: Measure.raw60)
            .foregroundStyle(Palette.secondary.color)
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
    }
    .background(Palette.background.color)
}
