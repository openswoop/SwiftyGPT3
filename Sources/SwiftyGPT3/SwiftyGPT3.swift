import Foundation
import Alamofire

public struct SwiftyGPT3 {
    // Engines
    public enum Engine: String {
        // Base
        case davinci = "text-davinci-002"
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
        temperature: Double = 0,
        topP: Double = 1.0,
        frequencePenalty: Double = 0,
        presencePenalty: Double = 0,
        engine: Engine = .davinci,
        completionHandler: @escaping (Any?, AFError?) -> Void
    ) {
        let parameters: [String: Any] = [
            "prompt": prompt!,
            "temperature": temperature,
            "max_tokens": maxTokens,
            "top_p": topP,
            "frequency_penalty": frequencePenalty,
            "presence_penalty": presencePenalty,
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
            .responseDecodable(of: CompletionData.self) { response in
                print(String(data: response.data ?? Data(), encoding: .utf8))
                    do {
                        completionHandler(try response.result.get().choices.first?.text ?? "", nil)
                    } catch {
                        print(error)
                        completionHandler(nil, nil)
                    }
    
            }
    }
    
    // TODO: Other OpenAI Endpoints
    // - Classification
    // - Semeantic Search
    // - Question Answering
}
