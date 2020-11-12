# Quick Start

`SpeechKit` is available for installation using the Cocoa dependency manager [CocoaPods](http://cocoapods.org/). 

```ruby
# CocoaPods
pod "SpeechKit", "~> 0.0.1"
```

## Usage

To integrate the SDK you can follow these steps.

Importing the framework.
``` Swift
 import SpeechKit
```

Set the delegate for the player.

``` Swift
SpeechKit.Player.shared.delegate = self
```

Set up an article 

``` Swift
let config = SpeechKit.Player.Config(
    projectId: "123",
    articleId: .podcastId("123")
)
SpeechKit.Player.shared.loadArticle(with: config)
```

Play/pause the article

``` Swift
SpeechKit.Player.shared.play()
SpeechKit.Player.shared.pause()
```

Getting the progress and events.

``` Swift
extension ViewController: SpeechKit.PlayerDelegate {
    func player(player: Player, changedState state: Player.State) {
        switch state {
        case .readyToPlay:
            if player.isPlaying == false {
                player.play()
            }
        default:
            break
        }
    }
    
    func player(player: Player, updatedProgression time: TimeInterval, duration: TimeInterval) {
        print("currenTime \(time), duration: \(duration)")
    }
}
```
