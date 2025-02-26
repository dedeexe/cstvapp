import SwiftUI

protocol ViewFactory {
    func makeView() -> AnyView
}

typealias Routable = ViewFactory & Hashable

protocol NavigationCoordinator {
    func push(_ path: any Routable)
    func popLast()
    func popToRoot()
}

class AppRouter: ObservableObject, NavigationCoordinator {
    @Published var paths: NavigationPath

    init(paths: NavigationPath = NavigationPath()) {
        self.paths = paths
    }

    func getInitialRouter() -> any Routable {
        let router = CSGOMatchesListRouter(rootCoordinator: self)
        return router
    }

    func push(_ path: any Routable) {
        Task { @MainActor [weak self] in
            self?.paths.append(AnyRoutable(path))
        }
    }

    func popLast() {
        Task { @MainActor [weak self] in
            self?.paths.removeLast()
        }
    }

    func popToRoot() {
        Task { @MainActor [weak self] in
            guard let self else { return }
            self.paths.removeLast(self.paths.count)
        }
    }
}

