import SwiftUI

struct CSGOMatchesListScreen: View {
    @StateObject var viewModel: CSGOMatchesListViewModel

    init(viewModel: CSGOMatchesListViewModel = CSGOMatchesListViewModel()) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        ZStack {
            Palette.background.color

            if viewModel.isLoading {
                Text("Loading...")
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
    }

    var matchesList: some View {
        List(viewModel.matches) { match in
            MatchCardView(match: match)
                .padding(Measure.raw1)
                .listRowSeparator(.hidden)
                .listRowBackground(Palette.background.color)
        }
        .listStyle(.plain)
    }
}

#Preview {
    CSGOMatchesListScreen()
}
