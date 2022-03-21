# Quick Start

`BeyondWords` is available for installation using [Swift Package Manager](https://www.swift.org/package-manager/) and Cocoa dependency manager [CocoaPods](http://cocoapods.org/).

### Swift Package Manager

Search for the repository url in the build in `Package Dependencies` screen:

```
https://github.com/SpeechKit/speechkit-ios-sdk-public.git
```

### Cocoapods

```ruby
pod "SpeechKit", :git => "https://github.com/SpeechKit/speechkit-ios-sdk-public.git"
```

## Usage

To integrate the SDK you can follow these steps.

Importing the framework.

``` Swift
 import BeyondWords
```

Set the delegate for the player.

``` Swift
BeyondWords.Player.shared.delegate = self
```

OR [optional]: using the built-in BeyondWords UI:

First place a PlayerView (UIView sublass) into your view heirachy (if you are doing this via interface builder, make sure to set Custom Class to `PlayerView` with Module `BeyondWords`). Then:
``` Swift
    
    @IBOutlet weak var playerView: PlayerView!

    ...

override func viewDidLoad() {
    super.viewDidLoad()

    BeyondWords.Player.shared.delegate = playerView

    ...

}
```

### Fetching an article 

``` Swift
let config = BeyondWords.Player.Config(
    projectId: "123",
    articleId: .podcastId("123")
)
BeyondWords.Player.shared.getArticle(with: config) { result in
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
    BeyondWords.Player.shared.playArticle(article: article, shouldAutoPlay: true)
}
```


### Playing an article

if shouldAutoPlay is true, the player will start automatically playing the article as soon as it starts loading the buffer.

``` Swift
BeyondWords.Player.shared.playArticle(article: article, shouldAutoPlay: true)
```


### Resume/pause the article

``` Swift
BeyondWords.Player.shared.resume()
BeyondWords.Player.shared.pause()
```


### Getting the progress and events.

``` Swift
extension ViewController: BeyondWords.PlayerDelegate {
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
