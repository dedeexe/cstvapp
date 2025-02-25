struct ConfigProvider {
    enum Game: String {
        case none = ""
        case csgo = "csgo"
    }

    var baseURL: String {
        "https://api.pandascore.co/"
    }

    func baseURLFor(game: Game) -> String {
        if game == .none {
            return baseURL
        }
        
        return baseURL + game.rawValue + "/"
    }
}
