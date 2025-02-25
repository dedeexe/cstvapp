#if DEBUG
import Foundation

extension Team {
    static func fixture(
        id: String = "1",
        name: String = "TeamA",
        imageURL: URL? = URL(string: "https://www.publicdomainpictures.net/pictures/170000/velka/landschaft-1463581037RbE.jpg"),
        players: [Player] = [
            .fixture(id: "1", name: "First Player", nickname: "P1"),
            .fixture(id: "2", name: "Second Player", nickname: "P2"),
            .fixture(id: "3", name: "Third Player", nickname: "P3")
        ]
    ) -> Team {
        Team(id: id, name: name, imageURL: imageURL, players: players)
    }
}
#endif
