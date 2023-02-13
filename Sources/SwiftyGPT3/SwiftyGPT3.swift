import Foundation
import Alamofire

public struct SwiftyGPT3 {
    // Engines
    public enum Engine: String {
        // Base
        case davinci = "text-davinci-003"
        case curie
        case babbage
        case ada
        
        // Instruct
        case davinciInstructBeta = "davinci-instruct-beta"
        case curieInstructBeta = "curie-instruct-beta"
        
        // Codex
        case davinciCodex = "davinci-codex"
        case cushmanCodex = "cushman-codex"
    }
    
    // Initializer
    private var apiKey: String!
    public init(apiKey: String!) {
        self.apiKey = apiKey
    }
    
    // Base URL
    private func getURL(function: String, engine: Engine = .davinci) -> String {
        return "https://api.openai.com/v1/engines/\(engine.rawValue)/\(function)"
    }
    
    // MARK: Completion Endpoint
    public func performCompletions(
        prompt: String!,
        maxTokens: Double = 60,
        temperature: Double = 0,
        topP: Double = 1.0,
        frequencePenalty: Double = 0,
        presencePenalty: Double = 0,
        engine: Engine = .davinci) async throws -> String {
            let session = URLSession(configuration: .default)
            var request = try URLRequest(url: getURL(function: "completions", engine: engine), method: .post)
            let parameters = CompletionInput(prompt: prompt!, temperature: temperature, max_tokens: maxTokens, top_p: topP, frequency_penalty: frequencePenalty, presence_penalty: presencePenalty)
            
            
            let headers: HTTPHeaders = [
                "Authorization": "Bearer \(self.apiKey!)",
                "Content-Type": "application/json"
            ]
            
            
            request.headers = headers
            
            let response = try await session.upload(for: request, from: JSONEncoder().encode(parameters))
            let completion = try JSONDecoder().decode(CompletionData.self, from: response.0)
            return completion.choices.first?.text ?? ""
            
            
        }
}
