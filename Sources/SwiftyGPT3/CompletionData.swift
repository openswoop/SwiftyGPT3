//
//  File.swift
//  
//
//  Created by Andreas Ink on 11/16/22.
//

import Foundation

struct CompletionData: Codable {
    var id: String
    var object: String
    var choices: [Choices]
    var created: Double
    var model: String
    var usage: Usage
}

struct Choices: Codable {
    var text: String
    var index: Int
    var logprobs: Int?
    var finish_reason: String
}
struct Usage: Codable {
    var prompt_tokens: Int?
    var completion_tokens: Int?
    var total_tokens: Int?

}
