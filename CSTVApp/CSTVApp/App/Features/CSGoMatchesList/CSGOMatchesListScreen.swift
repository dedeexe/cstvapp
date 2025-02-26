import SwiftUI

struct CSGOMatchesListScreen: View {
    @StateObject var viewModel: CSGOMatchesListViewModel

    init(viewModel: CSGOMatchesListViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        ZStack {
            Palette.background.color

            if viewModel.isLoading {
                SpinnerView()
            } else {
                matchesList
            }
        }
        .navigationTitle("Main Screen")
        .scrollContentBackground(.hidden)
        .foregroundStyle(.white)
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
        List(viewModel.matches) { match in
            MatchCardView(match: match)
                .padding(Measure.raw1)
                .listRowSeparator(.hidden)
                .listRowBackground(Palette.background.color)
                .onTapGesture {
                    viewModel.didTapMatch(match: match)
                }
        }
        .listStyle(.plain)
    }
}

#Preview {
    CSGOMatchesListScreen(viewModel: CSGOMatchesListViewModel(router: CSGOMatchesListRouter.previewMock))
}
