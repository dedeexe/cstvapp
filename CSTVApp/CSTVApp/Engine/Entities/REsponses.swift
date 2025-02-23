import Foundation


enum Response {

    typealias Matches = [Match]

    // MARK: - WelcomeElement
    struct Match: Decodable {
        let beginAt: String?
        let detailedStats: Bool?
        let draw: Bool?
        let endAt: String?
        let forfeit: Bool?
        let gameAdvantage: String?
        let games: [Game]?
        let id: Int?
        let league: League?
        let leagueId: Int?
        let live: Live?
        let matchType: String?
        let modifiedAt: String?
        let name: String?
        let numberOfGames: Int?
        let opponents: [OpponentElement]?
        let originalScheduledAt: String?
        let rescheduled: Bool?
        let scheduledAt: String?
        let serie: Serie?
        let serieId: Int?
        let slug, status: String?
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
        let imageURL: String?
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
    struct OpponentElement: Decodable {
        let opponent: OpponentOpponent?
        let type: String?
    }

    // MARK: - OpponentOpponent
    struct OpponentOpponent: Decodable {
        let acronym: String?
        let id: Int?
        let imageURL: String?
        let location: String?
        let modifiedAt: String?
        let name: String?
        let slug: String?
    }


    // MARK: - Serie
    struct Serie: Decodable {
        let beginAt: String?
        let endAt: String?
        let fullName: String?
        let id: Int?
        let leagueId: Int?
        let modifiedAt: String?
        let name, season, slug: String?
        let winnerId: String?
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
        let winnerId: String?
        let winnerType: String?
    }
}
