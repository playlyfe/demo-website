_ = require 'lodash'

module.exports = [
  '$rootScope', '$scope', 'API', 'Profile', '$timeout'
  ($rootScope ,  $scope ,  API ,  Profile,   $timeout) ->
    $scope.logged_in = false

    # Push notifications into queue
    $scope.notificationHandler = (notification) ->
      $rootScope.notifications.push notification
      # Set up notification clear timeout
      $timeout( ->
        $rootScope.notifications.shift()
        return
      , 5000)

    cleanup = [
      $rootScope.$on('player.refresh', ->
        API.playerGet({}, (player_profile) ->
          Profile.load(player_profile)
          return
        )
      )
      $rootScope.$on('player.load', ->
        API.playerGet({}, (player_profile) ->
          Profile.load(player_profile)
          API.player_id = player_profile.id
          API.notificationHandler = $scope.notificationHandler
          API.notificationStream({})
          return
        )
      )
    ]

    # Check if the user is logged into playlyfe
    API.statusGet({}, (result) ->
      $scope.logged_in = true
      $rootScope.$broadcast('player.load')
      return
    , (result) ->
      $scope.logged_in = false
      return
    )

    $scope.items = [
      {
        title: 'This is an Amazing Product'
        body: 'Wow!'
      }
      {
        title: 'This is even better than the last one'
        body: 'WOWOW !!'
      }
    ]

    $scope.$on '$destroy', ->
      _.forEach(cleanup, (callback) -> callback())
      return

    return
]
