import SwiftUI

class CSGOMatchesListRouter: Routable {

    private let rootCoordinator: NavigationCoordinator
    private let id: UUID

    init(rootCoordinator: NavigationCoordinator) {
        self.rootCoordinator = rootCoordinator
        self.id = UUID()
    }

    func rootToMatchDetails(match: Match) {
        let router = CSGOMatchDetailRouter(rootCoordinator: rootCoordinator, match: match)
        rootCoordinator.push(router)
    }
}

// MARK: - Routable Methods

extension CSGOMatchesListRouter {
    func makeView() -> AnyView {
        let viewModel = CSGOMatchesListViewModel(router: self)
        let view = CSGOMatchesListScreen(viewModel: viewModel)
        return AnyView(view)
    }

    static func == (lhs: CSGOMatchesListRouter, rhs: CSGOMatchesListRouter) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

#if DEBUG
extension CSGOMatchesListRouter {
    static let previewMock: CSGOMatchesListRouter = CSGOMatchesListRouter(rootCoordinator: AppRouter())
}
#endif
