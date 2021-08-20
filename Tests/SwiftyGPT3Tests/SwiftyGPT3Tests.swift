import XCTest
@testable import SwiftyGPT3

final class SwiftyGPT3Tests: XCTestCase {
    func testExample() async throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        
        let openai = SwiftyGPT3(apiKey: "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")
        let result = try await openai.completion(
            prompt: "user: hello\nbot: Hi! How can I help you today?\nuser:Tell me a joke\nbot:",
            engine: .davinci
        )
        print(result)
    }
}
