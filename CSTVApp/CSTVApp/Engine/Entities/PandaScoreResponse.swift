import Foundation

enum PandasScoreResponse {
    typealias Matches = [Match]
    typealias Players = [Player]

    // MARK: - Match[
    struct Match: Decodable {
        let id: Int?
        let beginAt: String?
        let detailedStats: Bool?
        let draw: Bool?
        let endAt: String?
        let forfeit: Bool?
        let gameAdvantage: String?
        let games: [Game]?
        let league: League?
        let leagueId: Int?
        let live: Live?
        let matchType: String?
        let modifiedAt: String?
        let name: String?
        let numberOfGames: Int?
        let opponents: [TeamInfo]?
        let originalScheduledAt: String?
        let rescheduled: Bool?
        let scheduledAt: String?
        let serie: Serie?
        let serieId: Int?
        let slug: String?
        let status: String?
        let tournament: Tournament?
    }

    // MARK: - Game
    struct Game: Decodable {
        let beginAt: String?
        let complete: Bool?
        let detailedStats: Bool?
        let endAt: String?
        let finished: Bool?
        let forfeit: Bool?
        let id: Int?
        let length: Int?
        let matchId: Int?
        let position: Int?
        let status: String?
        let winner: Winner?
        let winnerType: String?
    }

    // MARK: - Winner
    struct Winner: Decodable {
        let id: Int?
        let type: String?
    }

    // MARK: - League
    struct League: Decodable {
        let id: Int?
        let imageUrl: String?
        let modifiedAt: String?
        let name, slug: String?
        let url: String?
    }

    // MARK: - Live
    struct Live: Decodable {
        let opensAt: String?
        let supported: Bool?
        let url: String?
    }

    // MARK: - OpponentElement
    struct TeamInfo: Decodable {
        let opponent: Team?
        let type: String?
    }

    // MARK: - OpponentOpponent
    struct Team: Decodable {
        let id: Int?
        let name: String?
        let location: String?
        let slug: String?
        let players: [Player]?
        let modifiedAt: String?
        let acronym: String?
        let imageUrl: String?
        let currentVideogame: Videogame?
    }

    // MARK: - Videogame
    struct Videogame: Decodable {
        let id: Int?
        let name: String?
        let slug: String?
    }

    // MARK: - Serie
    struct Serie: Decodable {
        let id: Int?
        let beginAt: String?
        let endAt: String?
        let fullName: String?
        let leagueId: Int?
        let modifiedAt: String?
        let name: String?
        let season: String?
        let slug: String?
        let winnerId: Int?
        let winnerType: String?
        let year: Int?
    }

    // MARK: - Tournament
    struct Tournament: Decodable {
        let beginAt: String?
        let country: String?
        let detailedStats: Bool?
        let endAt: String?
        let hasBracket: Bool?
        let id: Int?
        let leagueId: Int?
        let liveSupported: Bool?
        let modifiedAt: String?
        let name: String?
        let prizepool: String?
        let region: String?
        let serieId: Int?
        let slug: String?
        let tier: String?
        let type: String?
        let winnerId: Int?
        let winnerType: String?
    }

    // MARK: - Player
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
        let imageUrl: String?
    }

    //MARK: - Error
    struct ErrorResponse: Decodable {
        let error: String?
    }

}
