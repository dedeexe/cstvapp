import SwiftUI

struct CompetitorsView: View {
    let firstTeam: Team
    let secondTeam: Team

    var body: some View {
        HStack(spacing: Spacing.normal) {
            TeamNameView(name: firstTeam.name, imageUrl: firstTeam.imageLogo)
            TextLabel("VS", style: .subtitle)
            TeamNameView(name: secondTeam.name, imageUrl: secondTeam.imageLogo)
        }
    }
}

#Preview {
    HStack {
        CompetitorsView(
            firstTeam: Team(name: "Team A", imageLogo: URL(string: "https://cdn.cdkitchen.com/recipes/images/2016/10/35608-6893-mx.jpg")),
            secondTeam: Team(name: "Team B", imageLogo: URL(string: "https://cdn.cdkitchen.com/recipes/images/2016/10/35608-6893-mx.jpg"))
        )
    }
    .background(Palette.background.color)
}
