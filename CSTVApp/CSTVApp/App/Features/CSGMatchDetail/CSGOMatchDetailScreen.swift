import SwiftUI

struct CSGOMatchDetailScreen: View {
    @StateObject var viewModel: CSGOMatchDetailScreenViewModel

    init(viewModel: CSGOMatchDetailScreenViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        ZStack {
            Palette.background.color

            if viewModel.isLoading {
                SpinnerView()
            } else {
                matchView
            }
        }
        .ignoresSafeArea()
        .toolbarColorScheme(.dark)
        .navigationTitle(viewModel.title)
        .navigationBarTitleDisplayMode(.inline)
        .scrollContentBackground(.hidden)
        .foregroundStyle(.white)
        .background(Palette.background.color)
        .toolbarBackground(Palette.background.color)
        .onAppear(perform: viewModel.getMatchDetail)
    }

    var matchView: some View {
        ScrollView {
            VStack {
                CompetitorsView(
                    firstTeam: viewModel.firstTeam,
                    secondTeam: viewModel.secondTeam
                )
                .padding(.bottom, Measure.raw24)

                TextLabel("Hoje, 21:00", style: .caption)
                    .padding(.bottom, Measure.raw24)

                VStack {
                    ForEach(viewModel.players, id: \.0.id) { (leftOpponent, rightOpponent) in
                        HStack {
                            createPlayerView(player: leftOpponent, style: .trailing)
                            createPlayerView(player: rightOpponent, style: .leading)
                        }
                    }
                }
            }
        }
    }

    private func createPlayerView(player: Player, style: PlayerView.Style) -> some View {
        PlayerView(player: player, style: style)
            .opacity(player.isEmpty ? 0 : 1)
    }
}

#Preview {
    NavigationStack {
        CSGOMatchDetailScreen(viewModel: CSGOMatchDetailScreenViewModel(matchId: "130064", router: .previewMock))
    }
}
