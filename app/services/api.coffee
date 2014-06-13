module.exports = [
  'Playlyfe', 'GameId', 'GameEnv'
  (Playlyfe, GameId, GameEnv) ->
    # GameId and GameEnv are read from the config.js file.
    # You only need to configure that file to run this demo.

    # If you are using the "test" environment, then
    # put app.environment as 'staging' in the config.js file.
    new Playlyfe(GameId, GameEnv or 'production')
]
