# Quick Start

`SpeechKit` is available for installation using the Cocoa dependency manager [CocoaPods](http://cocoapods.org/). 

```ruby
# CocoaPods
pod "SpeechKit", "~> 1.0.7"
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

OR [optional]: using the built-in Speechkit UI:

First place a PlayerView (UIView sublass) into your view heirachy (eg. via interface builder). Then:
``` Swift
    
    @IBOutlet weak var playerView: PlayerView!

    ...

override func viewDidLoad() {
    super.viewDidLoad()

    SpeechKit.Player.shared.delegate = playerView

    ...

}
```

### Fetching an article 

``` Swift
let config = SpeechKit.Player.Config(
    projectId: "123",
    articleId: .podcastId("123")
)
SpeechKit.Player.shared.getArticle(with: config) { result in
   switch result {
   case .success(let article):
       //Article has been fetched
   case .failure(let error):
       //Handle error
   }
}
```


### Article status

Some articles won't be ready to be played once fetched, we can check the article state before trying to playing them:
canBePlayed checks the status of the media and if the article contains a valid media url.

``` Swift
if article.canBePlayed {
    SpeechKit.Player.shared.playArticle(article: article, shouldAutoPlay: true)
}
```


### Playing an article

if shouldAutoPlay is true, the player will start automatically playing the article as soon as it starts loading the buffer.

``` Swift
SpeechKit.Player.shared.playArticle(article: article, shouldAutoPlay: true)
```


### Resume/pause the article

``` Swift
SpeechKit.Player.shared.resume()
SpeechKit.Player.shared.pause()
```


### Getting the progress and events.

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
