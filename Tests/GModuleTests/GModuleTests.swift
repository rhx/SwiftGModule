import XCTest
@testable import GModule

class GModuleTests: XCTestCase {

    func testSupported() {
        XCTAssertTrue(moduleSupported())
    }

    func testNonExistent() {
        XCTAssertNil(ModuleRef.open(fileName: "non/existent", flags: []))
    }

}
extension GModuleTests {
    static var allTests : [(String, (GModuleTests) -> () throws -> Void)] {
        return [
            ("testSupported",   testSupported),
            ("testNonExistent", testNonExistent),
        ]
    }
}
