# SwiftyGPT3

A simple Swift package to use with OpenAI's GPT-3 API.

## Requirements
This package currently uses Swift 5.5's async/await functions so as such, SwiftyGPT3 can only be used for:
- iOS 15.0 or later
- tvOS 15.0 or later
- watchOS 8.0 or later
- macOS 12.0 or later
- Xcode 13.0 or later

## Installation
Install this package with Swift Package Manager
`https://github.com/heysaik/SwiftyGPT3.git`
  
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

## Acknowledgements
- [gpt_3_dart](https://github.com/boronhub/gpt_3_dart)
