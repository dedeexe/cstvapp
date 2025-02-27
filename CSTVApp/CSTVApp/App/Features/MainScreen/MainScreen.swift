import SwiftUI
import UIKit

struct MainScreen: View {

    @StateObject var appRouter: AppRouter
    @StateObject var viewModel: MainViewModel = MainViewModel()
    @State private var animationPhase: SplashScreen.AnimationPhase = .opening

    var body: some View {
        switch viewModel.viewState {
        case .home:
            NavigationStack(path: $appRouter.paths) {
                appRouter.getInitialRouter().makeView()
                    .navigationDestination(for: AnyRoutable.self) { factory in
                        factory.makeView()
                    }
            }

        case .splash:
            SplashScreen(animationPhase: $viewModel.animationPhase)
                .onAppear(perform: viewModel.start)
        }
    }
}

#Preview {
    MainScreen(appRouter: AppRouter())
}
