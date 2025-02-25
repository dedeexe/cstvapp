#if DEBUG
import Foundation

extension League {
    static func fixture(
        name: String = "The League",
        imageURL: URL? = URL(string: "https://www.publicdomainpictures.net/pictures/170000/velka/landschaft-1463581037RbE.jpg")
    ) -> League {
        League(
            name: name,
            imageURL: imageURL
        )
    }
}
#endif
