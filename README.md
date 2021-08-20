# SwiftyGPT3

A simple Swift package to use with OpenAI's GPT-3 API.

## Installation


  
## Usage
```swift
import SwiftyGPT3

let openai = SwiftyGPT3(apiKey: "YOUR_API_KEY")
let result = try await openai.completion(prompt: "TEXT_PROMPT_HERE")
```

## TODO
- [x] Completion Endpoint
- [ ] Classification Endpoint
- [ ] Semantic Search Endpoint
- [ ] Question-Answering Endpoint
