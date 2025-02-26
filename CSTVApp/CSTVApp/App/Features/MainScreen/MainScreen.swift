import SwiftUI

struct MainScreen: View {
    @StateObject var appRouter: AppRouter

    var body: some View {
        NavigationStack(path: $appRouter.paths) {
            appRouter.getInitialRouter().makeView()
                .navigationDestination(for: AnyRoutable.self) { factory in
                    factory.makeView()
                }
        }
    }
}

#Preview {
    MainScreen(appRouter: AppRouter())
}
