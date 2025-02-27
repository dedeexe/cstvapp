import SwiftUI

struct MatchCardView: View {
    let match: Match

    var firstTeam: Team {
        match.teams[0]
    }

    var secondTeam: Team {
        match.teams[1]
    }

    init(match: Match) {
        self.match = match
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
            CachedImageView(imageURL: match.league.imageURL)
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
            match: .fixture(
                teams: [
                    .fixture(name: "A Team", imageURL: URL(string: "https://cdn.cdkitchen.com/recipes/images/2016/10/35608-6893-mx.jpg")),
                    .fixture(name: "B Team", imageURL: URL(string: "https://cdn.cdkitchen.com/recipes/images/2016/10/35608-6893-mx.jpg"))
                ]
            )
        )

        MatchCardView(
            match: .fixture(
                teams: [
                    .fixture(name: "C Team", imageURL: URL(string: "https://cdn.cdkitchen.com/recipes/images/2016/10/35608-6893-mx.jpg")),
                    .fixture(name: "D Team", imageURL: URL(string: "https://cdn.cdkitchen.com/recipes/images/2016/10/35608-6893-mx.jpg"))
                ],
                beginDate: Date(),
                endDate: Date()
            )
        )
    }
    .padding()
}

