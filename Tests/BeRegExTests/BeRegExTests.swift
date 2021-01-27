import XCTest
@testable import BeRegEx

final class BeRegExTests: XCTestCase {
    func testEmailMatching() {
        let usernameRegex = AnyOf(.alphanumerics, .custom("._%+-"))
            .oneOrMore()
        XCTAssertEqual(usernameRegex.compile(), "[a-zA-Z0-9._%+-]+")

        let domainRegex = AnyOf(.alphanumerics, .custom(".-")).oneOrMore() +
            Exact(".") +
            AnyOf(.letters).between(2...64)
        XCTAssertEqual(domainRegex.compile(), "[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,64}")

        let regex = Start() +
            usernameRegex.capture() +
            Exact("@") +
            domainRegex.capture() +
            End()
        XCTAssertEqual(regex.compile(), "^([a-zA-Z0-9._%+-]+)@([a-zA-Z0-9.-]+\\.[a-zA-Z]{2,64})$")
        
        let doesntMatch = regex.match("not.a.valid.because.domain@gmail.com-")
        XCTAssertEqual(doesntMatch, [])

        let doesMatch = regex.match("is.a.valid.email@gmail.com")
        let expectedMatch = Result(
            match: "is.a.valid.email@gmail.com",
            captures: ["is.a.valid.email", "gmail.com"],
            namedCaptures: [:]
        )
        XCTAssertEqual(doesMatch, [expectedMatch])
    }
    
    func testExact() {
        let regex = Exact(".")
        
        XCTAssertEqual(regex.compile(), "\\.")
    }
    
    func testAnyOf() {
        let regex = AnyOf(.letters, .numbers, .custom("._%+-"))
        
        XCTAssertEqual(regex.compile(), "[a-zA-Z0-9._%+-]")
        XCTAssertGreaterThan(regex.match("abc123ABC+").count, 0)
        XCTAssertEqual(regex.match("{").count, 0)
    }

    static var allTests = [
        ("testExample", testAnyOf),
    ]
}
