import SwiftUI

struct SplashScreen: View {
    enum AnimationPhase {
        case opening
        case closing
    }

    @Binding var animationPhase: AnimationPhase

    var body: some View {
        VStack {
            Image(Asset.logo.rawValue)
                .scaleEffect(isOpeningAnimation ? 1.0: 0.0)
                .rotationEffect(isOpeningAnimation ? .degrees(0) : .degrees(360))
                .opacity(isOpeningAnimation ? 1.0 : 0.0)
                .onAppear {
                    withAnimation(.bouncy.speed(0.75).delay(0.5)) {
                        animationPhase = .opening
                    }
                }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea()
        .background(Palette.background.color)
    }

    private var isOpeningAnimation: Bool {
        animationPhase == .opening
    }
}

#Preview {
    @Previewable @State var phase: SplashScreen.AnimationPhase = .closing
    SplashScreen(animationPhase: $phase)
}
