import XCTest
@testable import SwiftyGPT3

final class SwiftyGPT3Tests: XCTestCase {
    func testExample() async throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        
        let openai = SwiftyGPT3(apiKey: "API-KEY")
        let result = try await openai.completion(
            prompt: "user: hello\nbot: Hi! How can I help you today?\nuser:"
        )
        print(result)
    }
}
