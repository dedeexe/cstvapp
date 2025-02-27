import Foundation

class CSGOMatchesListViewModel: ObservableObject {

    @Published var matches: [Match] = []
    @Published var isLoadingMorePages: Bool = false
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    @Published var hasMorePages: Bool = true

    var matchesUseCase: CSGOMatchesListUseCase
    var referenceDate: Date = Date()
    var page = 1
    var isFirstTime = true

    var hasError: Bool {
        errorMessage != nil
    }

    private let router: CSGOMatchesListRouter

    init(
        matchesUseCase: CSGOMatchesListUseCase = CSGOMatchesListUseCase(),
        router: CSGOMatchesListRouter
    ) {
        self.matchesUseCase = matchesUseCase
        self.router = router
    }

    ///
    /// Get matches blocking other request until the current one hadn't finished
    ///
    func getMatches() {
        guard !isLoading, isFirstTime else {
            return
        }

        isLoading.toggle()
        fetchMatches()
    }

    ///
    /// Get matches - requested by Error State view
    ///
    func recoveryFromError() {
        isFirstTime = true
        page = 1
        getMatches()
    }

    ///
    /// Get matches - request for next page of matches
    ///
    func loadNextPage() {
        if hasMorePages {
            page += 1
            fetchMatches()
        }
    }

    ///
    /// Get Matchtes - Pull refresh
    ///
    func refresh() {
        page = 1
        isFirstTime = true
        referenceDate = Date()
        getMatches()
    }

    ///
    /// Route to
    ///
    func didTapMatch(match: Match) {
        router.rootToMatchDetails(match: match)
    }


    ///
    /// Get Matchtes - Used by other request implementation logic
    ///
    private func fetchMatches() {
        errorMessage = nil
        Task {
            do {
                let result = try await matchesUseCase.getMatches(beginDate: referenceDate, page: page)

                Task { @MainActor [weak self] in
                    self?.matches += result
                    self?.isLoading = false
                    self?.isFirstTime = false
                    self?.isLoadingMorePages = false
                    self?.errorMessage = nil
                }
            } catch {
                Task { @MainActor [weak self] in
                    self?.isLoading = false
                    self?.isFirstTime = false
                    self?.isLoadingMorePages = false
                    self?.errorMessage = L10n.ErrorMessage.generic.localized
                }
            }
        }
    }

    private func handleError(error: Error) {
        Task { @MainActor [weak self] in
            switch error {
            case CSGOMatchesListUseCase.UseCaseError.notMoreResults:
                self?.hasMorePages = false

            case CSGOMatchesListUseCase.UseCaseError.generic:
                self?.isLoading = false
                self?.isFirstTime = false
                self?.isLoadingMorePages = false
                self?.errorMessage = L10n.ErrorMessage.generic.localized

            default:
                break
            }
        }
    }
}
