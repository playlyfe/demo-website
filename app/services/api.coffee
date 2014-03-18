module.exports = [
  'Playlyfe'
  (Playlyfe) ->
    # production should be staging for the test environment
    new Playlyfe('playlyfe_demo_website', 'production')
]
