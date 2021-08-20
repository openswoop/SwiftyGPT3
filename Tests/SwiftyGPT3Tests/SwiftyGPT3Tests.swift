import XCTest
@testable import SwiftyGPT3

final class SwiftyGPT3Tests: XCTestCase {
    func testExample() async throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        
        let openai = SwiftyGPT3(apiKey: "API-KEY")
        let result = try await openai.completion(
            prompt: "user: add a box\nagft: [{\"name\": \"box1\", \"type\": \"cube\"}]\nuser: change the size to half a meter and change the color to matte black\nagft: [{\"name\": \"box1\", \"type\": \"cube\", \"size\": 0.5, \"shiny\": 0.0, \"color\": \"black\"}]\nuser: add a blue ball above the box and make it 30 centimeters in radius\nagft: [{\"name\": \"box1\", \"type\": \"cube\", \"size\": 0.5, \"shiny\": 0.0, \"color\": \"black\"}, {\"name\": \"ball1\", \"type\": \"sphere\", \"color\": \"blue\", \"position\": \"0,0,1\", \"radius\": 0.3}]\nuser: spin the ball around the box\nagft: [{\"name\": \"box1\", \"type\": \"cube\", \"size\": 0.5, \"shiny\": 0.0, \"color\": \"black\"}, {\"name\": \"ball1\", \"type\": \"sphere\", \"color\": \"blue\", \"position\": \"0,0,1\", \"radius\": 0.3, \"animation\": \"spin\", \"origin\": \"box1\"}]\nuser: add a green box next to the first box\nagft: [{\"name\": \"box1\", \"type\": \"cube\", \"size\": 0.5, \"shiny\": 0.0, \"color\": \"black\"}, {\"name\": \"ball1\", \"type\": \"sphere\", \"color\": \"blue\", \"position\": \"0,0,1\", \"radius\": 0.3, \"animation\": \"spin\", \"origin\": \"box1\"}, {\"name\": \"box2\", \"type\": \"cube\", \"color\": \"green\", \"position\": \"1,0,1\"}]\nuser: remove everything\nagft: []\nuser: add a red sphere\nagft:",
            maxTokens: 1573,
            temperature: 0.6,
            topP: 1.0
        )
        print(result)
    }
}
