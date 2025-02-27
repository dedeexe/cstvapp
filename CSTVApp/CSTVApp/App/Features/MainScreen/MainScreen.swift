import SwiftUI
import UIKit

struct MainScreen: View {

    @StateObject var appRouter: AppRouter
    @StateObject var viewModel: MainViewModel
    @State private var animationPhase: SplashScreen.AnimationPhase

    init(appRouter: AppRouter, viewModel: MainViewModel = MainViewModel(), animationPhase: SplashScreen.AnimationPhase = .opening) {
        self._appRouter = StateObject(wrappedValue: appRouter)
        self._viewModel = StateObject(wrappedValue: viewModel)
        self.animationPhase = animationPhase

        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.red] // Change title color
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.red]
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.red]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.red]
    }

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
