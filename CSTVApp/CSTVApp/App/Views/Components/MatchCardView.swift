import SwiftUI

struct MatchCardView: View {
    let match: Match

    var firstTeam: Team {
        match.teams[0]
    }

    var secondTeam: Team {
        match.teams[1]
    }

    var body: some View {
        VStack {
            HStack {
                Spacer()
                dateLabel
                    .padding(.trailing, -Measure.spaceNormal)
                    .padding(.top, -Measure.spaceNormal)
            }
            .frame(height: Measure.raw36)

            CompetitorsView(firstTeam: firstTeam, secondTeam: secondTeam)

            Rectangle()
                .frame(height: Measure.raw1)
                .foregroundStyle(Palette.separator.color)
                .padding(.bottom, Measure.spaceSmall)

            leagueView
        }
        .background(Palette.primary.color)
        .clipShape(RoundedRectangle(cornerRadius: Measure.radiusDefault))
    }

    var dateLabel: some View {
        TextLabel(match.formattedDate, style: .small)
            .frame(height: Measure.raw16)
            .padding(.top, Measure.spaceNormal)
            .padding(Measure.spaceSmall)
            .padding(.trailing, Measure.spaceNormal)
            .background(match.isRunning ? Palette.labelActive.color : Palette.labelDeactive.color)
            .clipShape(RoundedRectangle(cornerRadius: Measure.radiusDefault, style: .continuous))
    }

    var leagueView: some View {
        HStack {
            ImageView(imageURL: match.league.imageURL)
                .frame(width: Measure.raw16, height: Measure.raw16)
            TextLabel(match.leagueFullName)
            Spacer()
        }
        .padding([.leading, .bottom], Measure.spaceNormal)
    }
}

#Preview {
    VStack(spacing: 12) {
        MatchCardView(
            match: Match(
                id: "001",
                teams: [
                    Team(name: "Team A", imageURL: URL(string: "https://cdn.cdkitchen.com/recipes/images/2016/10/35608-6893-mx.jpg")),
                    Team(name: "Team B", imageURL: URL(string: "https://cdn.cdkitchen.com/recipes/images/2016/10/35608-6893-mx.jpg"))
                ],
                league: League(name: "Main League", imageURL: URL(string:"https://cdn.cdkitchen.com/recipes/images/2016/10/35608-6893-mx.jpg")),
                serie: Serie(fullName: "The League"),
                beginDate: Date(),
                endDate: Date().addingTimeInterval(300)
            )
        )

        MatchCardView(
            match: Match(
                id: "001",
                teams: [
                    Team(name: "Team A", imageURL: URL(string: "https://cdn.cdkitchen.com/recipes/images/2016/10/35608-6893-mx.jpg")),
                    Team(name: "Team B", imageURL: URL(string: "https://cdn.cdkitchen.com/recipes/images/2016/10/35608-6893-mx.jpg"))
                ],
                league: League(name: "Main League", imageURL: URL(string:"https://cdn.cdkitchen.com/recipes/images/2016/10/35608-6893-mx.jpg")),
                serie: Serie(fullName: "The League"),
                beginDate: Date(),
                endDate: Date().addingTimeInterval(-300)
            )
        )
    }
    .padding()
}

