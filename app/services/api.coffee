module.exports = [
  'Playlyfe'
  (Playlyfe) ->
    # If you are using the "test" environment, then
    # change the second argument from 'production' to 'staging'
    new Playlyfe('playlyfe_demo_website', 'production')
]
