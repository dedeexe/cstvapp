import Foundation

struct Player {
    var id: String
    var name: String
    var nickname: String
    var imageURL: URL?

    var isEmpty: Bool {
        id.isEmpty && name.isEmpty && nickname.isEmpty && imageURL == nil
    }
}

extension Player {
    static var empty: Player {
        Player(id: "", name: "", nickname: "", imageURL: nil)
    }
}
