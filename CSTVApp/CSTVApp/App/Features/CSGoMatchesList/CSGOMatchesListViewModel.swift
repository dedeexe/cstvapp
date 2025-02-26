import Foundation

class CSGOMatchesListViewModel: ObservableObject {

    @Published var matches: [Match] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil

    var matchesUseCase: CSGOMatchesListUseCase
    var referenceDate: Date = Date()
    var page = 1

    private let router: CSGOMatchesListRouter

    init(
        matchesUseCase: CSGOMatchesListUseCase = CSGOMatchesListUseCase(),
        router: CSGOMatchesListRouter
    ) {
        self.matchesUseCase = matchesUseCase
        self.router = router
    }

    func getMatches() {
        guard !isLoading else {
            return
        }

        isLoading.toggle()
        errorMessage = nil

        Task {
            let result = try await matchesUseCase.getMatches(beginDate: referenceDate, page: page)

            Task { @MainActor [weak self] in
                self?.matches += result
                self?.isLoading = false
            }
        }
    }

    func didTapMatch(match: Match) {
        router.rootToMatchDetails(match: match)
    }
}
