
# 20 Sec Basket

This game has been created for the [20 Second Game](https://itch.io/jam/20-second-game-jam) and [Game Off 2022](https://itch.io/jam/game-off-2022) game jams.

**20 Sec Basket** is a short game in which you need to score as many points as possible in just 20 seconds!

Use your mouse or touch screen to control the ball but be careful, each input will cost you one point in the value of the basket you'll score!

Submit your score and compete for the first place in the leaderboard!


## Gameplay

![](https://media.giphy.com/media/WSBlwsKrAfMcYrrYCE/giphy.gif)


## itch.io

The game can be freely played on itch.io

[![Available on itch.io](http://jessemillar.github.io/available-on-itchio-badge/badge-bw.png)](https://katnipdev.itch.io/20-second-basket)
## Features

I had never used Godot before so I tried to test out a few Engine's features adding the following:

- Adjustable gameplay length in the config file
- Particles FX template to add your own particles
- AudioManager to play your sound effects
- Integration with [SilentWolf](https://silentwolf.com/) for the leaderboard

## Development Documentation

Once you have cloned the repository, there's only one configuration step necessary to run your local game:

### Installing and configuring Silentwolf

- Register for a free account on [SilentWolf](https://silentwolf.com/)
- [Download the SilentWolf plugin](https://silentwolf.com/download) for Godot 3.x
- Extract the `silent_wolf` folder from the zip in your `.\addons` folder (you might need to create it)
- Copy (or rename) `.\AutoLoad\SilentWolf.config.example.gd` to `.\AutoLoad\SilentWolf.config.gd`
- Edit the content of the new file to match your SilentWolf game configuration
- Add `.\AutoLoad\SilentWolf.config.gd` to your project AutoLoads
- Reload the project

## License

[GNU GPLv3](https://choosealicense.com/licenses/gpl-3.0/)


## Acknowledgements

 - [MixKit](https://mixkit.co/free-sound-effects/basketball/) for the SFX
 - [loltsilol](https://opengameart.org/users/loltsilol) for the base [Basketball sprite](https://opengameart.org/content/basketball-0)

