import Foundation
import Alamofire

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
    private func getURL(function: String, engine: Engine = .davinci) -> String {
        return "https://api.openai.com/v1/engines/\(engine.rawValue)/\(function)"
    }
    
    // MARK: Completion Endpoint
    public func performCompletions(
        prompt: String!,
        maxTokens: Int = 60,
        temperature: Double = 0.9,
        topP: Double = 1.0,
        frequencePenalty: Double = 0,
        presencePenalty: Double = 0,
        bestOf: Int = 1,
        stopSequences: [String] = [],
        engine: Engine = .davinci,
        completionHandler: @escaping (Any?, AFError?) -> Void
    ) {
        let parameters: [String: Any] = [
            "prompt": prompt!,
            "temperature": temperature,
            "max_tokens": maxTokens,
            "top_p": topP,
            "best_of": bestOf,
            "frequency_penalty": frequencePenalty,
            "presence_penalty": presencePenalty,
            "stop": stopSequences
        ]
        
        // Construct the URL Request
        let openAIUrl = getURL(function: "completions", engine: engine)
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(self.apiKey!)",
            "Content-Type": "application/json"
        ]
        
        // Perform the request
        AF
            .request(openAIUrl, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { response in
                if let data = response.data {
                    let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
                    // Return the text completion
                    if let json = json,
                       let choices = json["choices"] as? [[String: Any]],
                       let completionsResponse = choices.first?["text"] as? String {
                        completionHandler(completionsResponse, nil)
                    } else {
                        completionHandler("GPT-3 could not get text completion", nil)
                    }
                }
            }
    }
    
    // TODO: Other OpenAI Endpoints
    // - Classification
    // - Semeantic Search
    // - Question Answering
}
