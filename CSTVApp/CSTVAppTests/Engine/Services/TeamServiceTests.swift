
@testable import CSTVApp
import XCTest

final class TeamServiceTests: XCTestCase {

    var sut: TeamService!
    var sut2: MatchesService!

    override func setUpWithError() throws {

    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAPIRequest() async throws {
        sut = TeamService()
        let result = try await sut.fetchTeam(id: "133009")
        print(result)
    }

    func testAPIRequest2() async throws {
        sut2 = MatchesService()
        let result = try await sut2.fetchMatch(id: 1131797)
        print(result)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
