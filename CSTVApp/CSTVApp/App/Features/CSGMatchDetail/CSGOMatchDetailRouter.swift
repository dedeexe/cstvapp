import SwiftUI

class CSGOMatchDetailRouter: Routable {

    let rootCoordinator: NavigationCoordinator
    let match: Match

    init(rootCoordinator: NavigationCoordinator, match: Match) {
        self.rootCoordinator = rootCoordinator
        self.match = match
    }

    func makeView() -> AnyView {
        let viewModel = CSGOMatchDetailScreenViewModel(matchId: match.id, router: self)
        let view = CSGOMatchDetailScreen(viewModel: viewModel)
        return AnyView(view)
    }

    static func == (lhs: CSGOMatchDetailRouter, rhs: CSGOMatchDetailRouter) -> Bool {
        lhs.match.id == rhs.match.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(match.id)
    }
}

#if DEBUG
extension CSGOMatchDetailRouter {
    static let previewMock = CSGOMatchDetailRouter(rootCoordinator: AppRouter(), match: .fixture(id: "130064"))
}
#endif
