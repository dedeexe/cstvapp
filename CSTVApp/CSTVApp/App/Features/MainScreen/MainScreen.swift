import SwiftUI

struct MainScreen: View {
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: Color.white]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
    }

    var body: some View {
        NavigationStack {
            CSGOMatchesListScreen()
        }
    }
}

#Preview {
    MainScreen()
}
