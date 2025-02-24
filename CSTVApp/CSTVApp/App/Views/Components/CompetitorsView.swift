import SwiftUI

struct CompetitorsView: View {
    let firstTeam: Team
    let secondTeam: Team

    var body: some View {
        HStack(spacing: Measure.spaceNormal) {
            TeamNameView(name: firstTeam.name, imageUrl: firstTeam.imageURL)
            TextLabel("VS", style: .subtitle)
            TeamNameView(name: secondTeam.name, imageUrl: secondTeam.imageURL)
        }
    }
}

#Preview {
    HStack {
        CompetitorsView(
            firstTeam: Team(name: "Team A", imageURL: URL(string: "https://cdn.cdkitchen.com/recipes/images/2016/10/35608-6893-mx.jpg")),
            secondTeam: Team(name: "Team B", imageURL: URL(string: "https://cdn.cdkitchen.com/recipes/images/2016/10/35608-6893-mx.jpg"))
        )
    }
    .background(Palette.background.color)
}
