@testable import CSTVApp
import XCTest

final class DateFormatViewTests: XCTestCase {

    let hour: TimeInterval = 60 * 60
    let day: TimeInterval = 60 * 60 * 24
    let year: TimeInterval = 60 * 60 * 24 * 365
    var initialDate: Date!
    var sut: DateFormatView!

    var mockInitialDate: Date {
        Date(timeIntervalSince1970: 0).addingTimeInterval(year * 50)
    }

    override func tearDownWithError() throws {
        sut = nil
        initialDate = nil
    }

    func test_formatDateByComparing_returnsNow() throws {
        let oneHourBefore = mockInitialDate.addingTimeInterval(-hour)
        let oneHourAfter = mockInitialDate.addingTimeInterval(hour)
        makeSUT(startDate: oneHourBefore, endDate: oneHourAfter)
        XCTAssertEqual(sut.formattedDate(), "Agora")
    }

    func test_formatDateByComparing_returnsTodayAndTime() throws {
        let hourAfter = Date().addingTimeInterval(hour)
        makeSUT(referenceDate: hourAfter)
        XCTAssertTrue(sut.formattedDate().contains("Hoje,"))
    }

    func test_formatDateByComparing_returnsWeekDayAndTime() throws {
        let hourAfter = mockInitialDate.addingTimeInterval(day * 4)
        makeSUT(startDate: hourAfter)
        XCTAssertEqual(sut.formattedDate(), "qui., 21:00")
    }

    func test_formatDateByComparing_returnsWeekDayDate() throws {
        let fiveDaysAfter = mockInitialDate.addingTimeInterval(day * 6)
        makeSUT(startDate: fiveDaysAfter)
        XCTAssertEqual(sut.formattedDate(), "19 dez., 21:00")
    }

    //MARK: - Helpers

    private func makeSUT(referenceDate: Date? = nil, startDate: Date? = nil, endDate: Date? = nil) {
        initialDate = referenceDate ?? mockInitialDate
        let match = Match(id: "001", teams: [], league: .fixture(), serie: .fixture(), beginDate: startDate, endDate: endDate, status: .finished)
        sut = DateFormatView(match: match)
    }
}
