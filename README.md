# SwiftyGPT3

A simple Swift package which acts as an OpenAI client for GPT-3. **Supports GPT-3 Codex!**

## Requirements
- iOS 10.0 or later
- tvOS 10.0 or later
- watchOS 3.0 or later
- macOS 10.12 or later
- Xcode 8.0 or later

## Installation
Install this package with Swift Package Manager
```
https://github.com/heysaik/SwiftyGPT3.git
```
  
## Usage
```swift
import SwiftyGPT3

let openai = SwiftyGPT3(apiKey: "YOUR-OPENAI-KEY")
openai.performCompletions(
    prompt: "User: Hi AI!\nAI: Hello! What can I help you with?\nUser: Can you please tell me what the weather is?",
    maxTokens: 60,
    stopSequences: ["User:"],
    engine: .davinci
) { result, _ in
    if let response = result {
        print(response)
    }
}
```

### Customizable Parameters
| Parameter | Description |
| --- | --- |
| `prompt` | GPT-3 completes its answers based on the prompt you give. Learn more about designing a great prompt [here](https://beta.openai.com/docs/guides/completion/prompt-design). |
| `maxTokens` | The maximum number of tokens to generate. Requests can use up to 2048 tokens shared between prompt and completion. *One token is roughly 4 characters for normal English text* |
| `temperature` | Controls randomness: Lowering results in less random completions. As the temperature approaches zero, the model will become deterministic and repetitive. |
| `topP` | Controls diversity via nucleus sampling: 0.5 means half of all likelihood-weighted options are considered. |
| `frequencePenalty` | How much to penalize new tokens based on their existing frequency in the text so far. Decreases the model's likelihood to repeat the same line verbatim. |
| `presencePenalty` | How much to penalize new tokens based on whether they appear in the text so far. Increases the model's likelihood to talk about new topics. |
| `bestOf` | Generates multiple completions server-side, and displays only the best. Streaming only works when set to 1. Since it acts as a multiplier on the number of completions, this parameters can eat into your token quota very quickly - **use caution!** |
| `stopSequenes` | Up to **four** sequences where the API will stop generating further tokens. The returned text will not contain the stop sequence. |
| `engine` | The engine to use for the API request. These engines provide a spectrum of capability, where davinci is the most capable and ada is the fastest. |

## TODO
- [x] Completion Endpoint
- [ ] Classification Endpoint
- [ ] Semantic Search Endpoint
- [ ] Question-Answering Endpoint

## Acknowledgements
- [gpt_3_dart](https://github.com/boronhub/gpt_3_dart)
