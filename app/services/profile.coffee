module.exports = [
  '$rootScope'
  ($rootScope) ->
    $rootScope.notifications = []

    @load = (player_profile) =>
      $rootScope.player = player_profile
      return
    return
]
