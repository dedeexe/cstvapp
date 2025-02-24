import SwiftUI

struct ContentView: View {
    var fetcher = MatchesService()
    let date = Date()

    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .task {
            await requestData()
        }
    }

    func requestData() async {
        do {
            let result = try await fetcher.fetchMatches(beginningAt: date, page: 1)
            print(result ?? "")
        } catch {
            print(error.localizedDescription)
        }
    }
}

#Preview {
    ContentView()
}


/*
 1. Set ColorSet
 2. Set Typography
 3. Components:
    - Team Logo Name
    - Match Card with time and league info
    - Math player Cardo (Left aligned and right aligned)
 */

//"https://api.pandascore.co/videogames"


