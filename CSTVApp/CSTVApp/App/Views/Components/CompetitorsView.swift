import SwiftUI

struct CompetitorsView: View {
    let firstTeam: Team
    let secondTeam: Team

    var body: some View {
        HStack(spacing: Measure.spaceNormal) {
            TeamNameView(name: firstTeam.name, imageUrl: firstTeam.imageURL)
            TextLabel(L10n.General.versus.localized, style: .subtitle)
            TeamNameView(name: secondTeam.name, imageUrl: secondTeam.imageURL)
        }
    }
}

#Preview {
    HStack {
        CompetitorsView(
            firstTeam: Team(id: "1", name: "Team A", imageURL: URL(string: "https://cdn.cdkitchen.com/recipes/images/2016/10/35608-6893-mx.jpg"), players: []),
            secondTeam: Team(id: "2", name: "Team B", imageURL: URL(string: "https://cdn.cdkitchen.com/recipes/images/2016/10/35608-6893-mx.jpg"), players: [])
        )
    }
    .background(Palette.background.color)
}
