struct ConfigProvider {
    enum Game: String {
        case csgo = "csgo"
    }

    var baseURL: String {
        "https://api.pandascore.co/"
    }

    func baseURLFor(game: Game) -> String {
        baseURL + game.rawValue + "/"
    }
}
