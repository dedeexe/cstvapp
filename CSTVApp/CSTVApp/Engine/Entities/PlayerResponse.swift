extension Response {
    typealias Players = [Player]

    struct Player: Decodable {
        let active: Bool?
        let id: Int?
        let name: String?
        let role: String?
        let slug: String?
        let modifiedAt: String?
        let age: Int?
        let birthday: String?
        let firstName: String?
        let lastName: String?
        let nationality: String?
        let imageURL: String?
    }
}
