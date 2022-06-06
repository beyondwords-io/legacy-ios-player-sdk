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


# Public API Documentation

## Player

Easily accessable class to use BeyondWords API. Handles events and state changes for AudioPlayer, a built in wrapper around AVPlayer.

### Variables

#### `currentArticle` Article?
Returns the currently set Article

#### `isPlayingAd` Bool
Returns if the player is playing advertisment or not

#### `delegate` PlayerDelegate?
Player delegate reference

#### `shared ` Player
Singleton Player object

#### `currentTime` Double
Current position for the current article

#### `duration` Double
Duration for the current article

#### `isPlaying` Bool
Returns true if article is playing, false if article is paused

### Functions

#### `getArticle(with config: Config, completion: @escaping (Result<Article, Error>) -> Void)`
Loads an article from the API
<br>`config`: Article identification
<br>`completion`: Article result or Error

#### `playArticle(article: Article, shouldAutoPlay: Bool = true)`
Plays the given article
<br>`article`: Article from the API
<br>`shouldAutoPlay`: If `true` the player starts the `Article` automatically

#### `resume()`
Plays the current article if it has been buffered

#### `pause()`
Pauses the current article if it is playing
    
#### `changePlaybackRate(_ value: PlaybackRate)`
Sets the playback rate for the user. This value will show up on player UI.
<br>`value`: Accepts any `PlaybackRate` or `nil`. If you pass `nil`, `AudioPlayer` will cycle through all possibilities by default
    
#### `seek(to seconds: Double)`
Seeks a to determinate position if an article is being reproduced
<br>`seconds`: Seconds to seek to


## Playerview
Built in Player UI.

### Variables

#### `buttonBackgroundColor ` UIColor?
Sets the background color of the Play and Pause buttons.

#### `buttonIconColor` UIColor?
Sets the color of the Play and Pause button icons.

#### `seekingButtonsColor` UIColor?
Sets the color of the seeking buttons.

#### `progressColor` UIColor?
Sets the tinting color of the progress bar.

#### `trackColor` UIColor?
Sets the track color of the progress bar.

#### `textColor` UIColor?
Sets the colors of the texts on the player

#### `showsSeekingButtons` UIColor?
Sets hidden of visible the seeking buttons.
    
### Functions
    
#### `clearPlayer()`
Resets UI elements to default


## PlayerDelegate
Delegate functions to react on AudioPlayer state changes.

### Functions

#### `player(player: Player, changedState state: Player.State)`
Called every time the state of the AudioPlayer has changed
<br>`player`: Actual Player instance
<br>`state`: The new state

#### `player(player: Player, updatedProgression time: TimeInterval, duration: TimeInterval)`
Called when an article is playing
<br>`player`: Actual Player instance
<br>`time`: Actual progress on the player
<br>`duration`: Duration of the asset

#### `player(_ player: Player, didChangePlaybackRate playbackRate: PlaybackRate?)`
Called when the user choose a new `PlaybackRate`
<br>`player`: Actual Player instance
<br>`playbackRate`: The new playback rate

#### `playerDidPlayToEnd(_ player: Player)`
Called when an article reaches the end
<br>`player`: Actual Player instance


## BeyondWordsApiError
Enum to represent various errors while communicating with the API.
<br>Cases:
`invalidReponse`
`authenticationError`
`badRequest`
`decodableError`


## Player.State
Enum to represent various states on the `Player`.
<br>Cases: 
`unknown`
`readyToPlay`
`buffering`
`failed(Error)`
`paused`
`playing(advertiser: String?, adUrl: String?)`


## Config
Struct to build up the article that has to be reproduced.
<br>`projectId` String
<br>`articleId` ArticleIdentifier


## ArticleIdentifier
Enum to identify an article.
<br>Cases:
`url(String)`
`podcastId(String)`
`externalId(String)`


## Article
Represents an asset from the API.
<br>`projectId` Int: Id of the project the article belongs to
<br>`podcast` Podcast: A `Podcast` struct from the API
<br>`canBePlayed` Bool: Checks if the `Media` is processed and has an url
<br>`hasPodcastURL` Bool: Checks if the media has an url


## Article.CustomAd
Campaign information for advertisement. 
<br>`defaultMedia` Media: Gives the default `Media` for advertisement


## Article.Podcast
Information about the podcast to be played.
<br>`podcast_id` Int?: Id of the podcast
<br>`title` String?: Name of the podcast
<br>`author` String?: Author name for the podcast
<br>`image` String?: Image representation of the podcast
<br>`defaultMedia` Media: Gives the default `Media` for the podcast
<br>`isMediaProcessed` Bool: Checks if the `Media` is processed or not


## Media
Information about playable asset.

<br>`state` State: Current state of the media. Cases: `unprocessed`, `processed`, `processing`, `scheduled`, `skipped`, `handled`, `error`
<br>`duration` Float?: Duration of the asset
<br>`isStream` Bool: Checks if the media has `m3u8` or `m3u` extension
