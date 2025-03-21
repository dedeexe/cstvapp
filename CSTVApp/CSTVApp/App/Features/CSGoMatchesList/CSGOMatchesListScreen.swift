import SwiftUI

struct CSGOMatchesListScreen: View {
    @StateObject var viewModel: CSGOMatchesListViewModel

    init(viewModel: CSGOMatchesListViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        ZStack {
            Palette.background.color

            if viewModel.hasError {
                errorView
            } else if viewModel.isLoading {
                SpinnerView()
            } else {
                matchesList
            }
        }
        .navigationTitle(L10n.CSGOMatchList.title.localized)
        .scrollContentBackground(.hidden)
        .foregroundStyle(Palette.white.color)
        .background(Palette.background.color)
        .toolbarBackground(Palette.background.color)
        .toolbarColorScheme(.dark)
        .onAppear {
            viewModel.getMatches()
        }
        .refreshable {
            viewModel.refresh()
        }
    }

    var matchesList: some View {
        List {
            ForEach(viewModel.matches) { match in
                MatchCardView(match: match)
                    .padding(Measure.raw1)
                    .listRowSeparator(.hidden)
                    .listRowBackground(Palette.background.color)
                    .onTapGesture {
                        viewModel.didTapMatch(match: match)
                    }
            }

            if viewModel.hasMorePages {
                paginationView
                    .listRowSeparator(.hidden)
                    .listRowBackground(Palette.background.color)
            }
        }
        .listStyle(.plain)
    }

    var paginationView: some View {
        SpinnerView()
            .frame(maxWidth: .infinity)
            .frame(height: Measure.raw60)
            .onAppear(perform: viewModel.loadNextPage)
    }

    var errorView: some View {
        ErrorMessageView(message: viewModel.errorMessage ?? "") {
            viewModel.recoveryFromError()
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    CSGOMatchesListScreen(viewModel: CSGOMatchesListViewModel(router: CSGOMatchesListRouter.previewMock))
}
