import Foundation

class CSGOMatchesListViewModel: ObservableObject {

    @Published var matches: [Match] = []
    @Published var isRefreshLoading: Bool = false
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil

    var matchesUseCase: CSGOMatchesListUseCase
    var referenceDate: Date = Date()
    var page = 1
    var isFirstTime = true

    private let router: CSGOMatchesListRouter

    init(
        matchesUseCase: CSGOMatchesListUseCase = CSGOMatchesListUseCase(),
        router: CSGOMatchesListRouter
    ) {
        self.matchesUseCase = matchesUseCase
        self.router = router
    }

    func getMatches(byPullRefresh: Bool = false) {
        guard !isLoading && !isRefreshLoading, isFirstTime else {
            return
        }

        if byPullRefresh {
            self.isRefreshLoading.toggle()
        } else {
            isLoading.toggle()
        }

        errorMessage = nil

        Task {
            let result = try await matchesUseCase.getMatches(beginDate: referenceDate, page: page)

            Task { @MainActor [weak self] in
                self?.matches += result
                self?.isLoading = false
                self?.isFirstTime = false
                self?.isRefreshLoading = false
            }
        }
    }

    func refresh() {
        page = 1
        isFirstTime = true
        referenceDate = Date()
        getMatches(byPullRefresh: true)
    }

    func didTapMatch(match: Match) {
        router.rootToMatchDetails(match: match)
    }
}
