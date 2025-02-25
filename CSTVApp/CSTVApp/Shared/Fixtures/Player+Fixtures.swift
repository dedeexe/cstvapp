#if DEBUG
import Foundation

extension Player {
    static func fixture(
        id: String = "1",
        name: String = "Player",
        nickname: String = "DPlayer",
        imageURL: URL? = URL(string: "https://www.publicdomainpictures.net/pictures/170000/velka/landschaft-1463581037RbE.jpg")
    ) -> Player {
        Player(id: id, name: name, nickname: nickname, imageURL: imageURL)
    }
}
#endif
