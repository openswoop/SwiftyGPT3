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
        return "https://api.openai.com/v1/engines/\(engine)/\(function)"
    }
    
    // MARK: Completion Endpoint
    public func performCompletions(
        prompt: String!,
        maxTokens: Int = 150,
        temperature: Double = 0.9,
        topP: Double = 1.0,
        frequencePenalty: Double = 0,
        presencePenalty: Double = 0,
        bestOf: Int = 1,
        engine: Engine = .davinci,
        completionHandler: @escaping (Any?, AFError?) -> Void
    ) {
        // Form a dictionary from the parameters
        let parameters: [String: Any] = [
            "temperature": temperature,
            "max_tokens": maxTokens,
            "top_p": topP,
            "best_of": bestOf,
            "frequency_penalty": frequencePenalty,
            "presence_penalty": presencePenalty
        ]
        // Construct the request URL
        let openAIUrl = getURL(function: "completions", engine: engine)
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(self.apiKey!)",
            "Contet-Type": "application/json"
        ]
        
        AF
            .request(openAIUrl, method: .post, parameters: parameters, headers: headers)
            .response { response in
                
                switch response.result {
                case .success(let value):
                    
                    if let data = value {
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
                    
                case .failure(let error):
                    completionHandler(nil, error)
                }
            
            }
    }
    
    // TODO: Other OpenAI Endpoints
    // - Classification
    // - Semeantic Search
    // - Question Answering
}
