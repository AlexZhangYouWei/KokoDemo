import XCTest

final class KokoDemoUITests: XCTestCase {
    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLaunchShowsEntryButtons() throws {
        let app = XCUIApplication()
        app.launch()

        XCTAssertTrue(app.buttons["無好友"].waitForExistence(timeout: 3))
        XCTAssertTrue(app.buttons["好友列表無邀請"].exists)
        XCTAssertTrue(app.buttons["好友列表含邀請好友"].exists)
    }
}
