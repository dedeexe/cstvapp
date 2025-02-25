import Foundation

struct Team {
    var id: String
    var name: String
    var imageURL: URL?
    var players: [Player]
}

extension Team {
    static var empty: Team {
        Team(id: "", name: "", players: [])
    }
}
