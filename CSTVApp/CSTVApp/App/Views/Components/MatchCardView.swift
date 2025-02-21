import SwiftUI

struct MatchCardView: View {
    let firstTeam: Team
    let secondTeam: Team

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
                .foregroundStyle(Palette.primary.color)
                .padding(.bottom, Measure.spaceSmall)

            leagueView
        }
        .background(Palette.background.color)
        .clipShape(RoundedRectangle(cornerRadius: Measure.radiusDefault))
    }

    var dateLabel: some View {
        TextLabel("Now fdsafsd", style: .small)
            .frame(height: Measure.raw16)
            .padding(.top, Measure.spaceNormal)
            .padding(Measure.spaceSmall)
            .padding(.trailing, Measure.spaceNormal)
            .background(.red)
            .clipShape(RoundedRectangle(cornerRadius: Measure.radiusDefault, style: .continuous))
    }

    var leagueView: some View {
        HStack {
            ImageView(imageURL: nil)
                .frame(width: Measure.raw16, height: Measure.raw16)
            TextLabel("League + serie")
            Spacer()
        }
        .padding([.leading, .bottom], Measure.spaceNormal)
    }
}

#Preview {
    HStack {
        MatchCardView(
            firstTeam: Team(name: "Team A", imageLogo: URL(string: "https://cdn.cdkitchen.com/recipes/images/2016/10/35608-6893-mx.jpg")),
            secondTeam: Team(name: "Team B", imageLogo: URL(string: "https://cdn.cdkitchen.com/recipes/images/2016/10/35608-6893-mx.jpg"))
        )
    }
}

