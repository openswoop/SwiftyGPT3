import XCTest
@testable import SwiftyGPT3

final class SwiftyGPT3Tests: XCTestCase {
    func testExample() {
        let openai = SwiftyGPT3(apiKey: "YOUR-OPENAI-KEY")
        let e = expectation(description: "Alamofire")

        openai.performCompletions(
            prompt: "User: Hi AI!\nAI: Hello! What can I help you with?\nUser: Can you please tell me what the weather is?",
            maxTokens: 60,
            stopSequences: ["User:"],
            engine: .davinci
        ) { result, error in
            if let response = result {
                print(response)
            }
            e.fulfill()
        }
        
        waitForExpectations(timeout: 10.0, handler: nil)
    }
}
