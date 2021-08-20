import Foundation

public struct SwiftyGPT3 {
    // Engines
    public enum Engine: String {
        // Base
        case davinci
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
    private func getURL(function: String, engine: Engine = .davinci) -> URL? {
        return URL(string: "https://api.openai.com/v1/engines/\(engine)/\(function)")
    }
    
    // MARK: Completion Endpoint
    public func completion(
        prompt: String!,
        maxTokens: Int = 150,
        temperature: Double = 0.9,
        topP: Double = 1.0,
        frequencePenalty: Double = 0,
        presencePenalty: Double = 0,
        bestOf: Int = 1,
        engine: Engine = .davinci
    ) async throws -> String {
        // Form a dictionary from the parameters
        let parameters: [String: Any] = [:]
        
        // Construct the request URL
        guard let openAIUrl = getURL(function: "completions", engine: engine),
              let payload = try? JSONSerialization.data(withJSONObject: parameters) else {
                  return "Please make sure you are using valid parameters"
              }
        
        var request = URLRequest(url: openAIUrl)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(self.apiKey!)", forHTTPHeaderField: "Authorization")
        request.httpBody = payload
        
        // Async function to make a call to OpenAI
        let (data, _) = try await URLSession.shared.data(from: openAIUrl)
        
        // Return the text completion
        let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
        print(json)
        
        if let json = json,
           let choices = json["choices"] as? [[String: Any]],
           let completion = choices.first?["text"] as? String {
            return completion
        } else {
            return "GPT-3 could not get text completion"
        }
    }
    
    // TODO: Other OpenAI Endpoints
    // - Classification
    // - Semeantic Search
    // - Question Answering
}
