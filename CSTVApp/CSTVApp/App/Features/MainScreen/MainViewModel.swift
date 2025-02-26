import Foundation

class MainViewModel: ObservableObject {

    typealias AnimationPhase = SplashScreen.AnimationPhase

    enum ViewState {
        case home
        case splash
    }

    @Published var viewState: ViewState = .splash
    @Published var animationPhase: AnimationPhase = .closing

    init() {
        // Do Nothing
    }

    func start() {
        animationPhase = .opening
        Task {
            try await Task.sleep(nanoseconds: 3_000_000_000)

            Task { @MainActor [weak self] in
                self?.routeToMatchesScreen()
            }
        }
    }

    func routeToMatchesScreen() {
        viewState = .home
    }
}
