import SwiftUI

struct MainScreen: View {
    init() {
    }

    var body: some View {
        NavigationStack {
            CSGOMatchesListScreen()
            //CSGOMatchDetailScreen()
        }
    }
}

#Preview {
    MainScreen()
}
