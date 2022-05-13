# Quick Start #

## 1. Add repositories

Describe how to add main repo (e.g. Repsy, Cocoapods) to the customer's project. Include code snippet to showcase an example.
### Swift Package Manager

Search for the repository url on the Package Dependencies screen:

https://github.com/SpeechKit/speechkit-ios-sdk-public.git

### Cocoapods
```
pod "SpeechKit", :git => "https://github.com/SpeechKit/speechkit-ios-sdk-public.git"
```

## 2. Add the BeyondWords SDK module dependency ##

### Importing the framework.

```
import BeyondWords
```

## Usage

### Set the delegate for the player.

```
BeyondWords.Player.shared.delegate = self
```

### OR [optional]: use the built-in BeyondWords UI:

First place a PlayerView (UIView sublass) into your view heirachy (if you are doing this via interface builder, make sure to set Custom Class to PlayerView with Module BeyondWords). Then:

```
@IBOutlet weak var playerView: PlayerView!

...

override func viewDidLoad() {
    super.viewDidLoad()

    BeyondWords.Player.shared.delegate = playerView
}
```

### Playing an article

if shouldAutoPlay is true, the player will start automatically playing the article as soon as it starts loading the buffer.

```
BeyondWords.Player.shared.playArticle(article: article, shouldAutoPlay: true)
```

### Resume/pause the article

```
BeyondWords.Player.shared.resume()
BeyondWords.Player.shared.pause()
```

### Getting the progress and events.

```
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

## Customising the default player UI

Built in PlayerView can be customised to achieve the desired look and feel. Simply use your own values to set the available properties.

```
@IBOutlet weak var playerView: PlayerView!

override func viewDidLoad() {
    super.viewDidLoad()
    
    BeyondWords.Player.shared.delegate = playerView
    
    let contentColor = UIColor.white
    let backgroundColor = UIColor.systemTeal
    
    playerView.backgroundColor = backgroundColor
    playerView.layer.cornerRadius = 8
    playerView.buttonBackgroundColor = contentColor
    playerView.buttonIconColor = backgroundColor
    playerView.progressColor = contentColor
    playerView.trackColor = contentColor.withAlphaComponent(0.3)
    playerView.textColor = contentColor
    playerView.seekingButtonsColor = contentColor
    playerView.showsSeekingButtons = true
}
```

## Fetching Metadata

```
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

Some articles won't be ready to be played once fetched, we can check the article state before trying to playing them: canBePlayed checks the status of the media and if the article contains a valid media url.

```
if article.canBePlayed {
    BeyondWords.Player.shared.playArticle(article: article, shouldAutoPlay: true)
}
```

### Playing an article

if `shouldAutoPlay` is true, the player will start automatically playing the article as soon as it starts loading the buffer.

```
BeyondWords.Player.shared.playArticle(article: article, shouldAutoPlay: true)
```

## Player Styling

| Property name | Example | Description |
| ---------- | --------------- | ----------- |
| buttonBackgroundColor | UIColor.black | Circular background of the play/pause button |
| buttonIconColor | UIColor.black | Play/pause icon color |
| progressColor | UIColor.black | Color of the full progress bar |
| trackColor | UIColor.black | Color only for the tracking of the progress bar |
| textColor | UIColor.black | Sets the color of all the labels |
| seekingButtonsColor | UIColor.black | Color of both seeking buttons |
| showsSeekingButtons| true | Enables seeking forward and backwards buttons |
