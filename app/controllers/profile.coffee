_ = require 'lodash'

module.exports = [
  '$scope', '$rootScope', 'API'
  ($scope ,  $rootScope ,  API) ->

    # Initial values on profile
    $scope.points = '0'
    $scope.level = null
    $scope.progress = 0
    $scope.achievements = []
    $scope.leaderboard = []

    # Update profile when player changes
    watchers = [
      $rootScope.$watch('player', (player) ->
        return unless player?
        # Set Points
        $scope.points = _.find(player.scores, (score) -> score.metric.id is 'points')?.value
        # Set Levels
        level = _.find(player.scores, (score) -> score.metric.id is 'level')
        if level?
          $scope.level = level.value
          $scope.progress = parseInt(
            (parseInt($scope.points) - parseInt(level.meta.low))/(parseInt(level.meta.high) - parseInt(level.meta.low)) * 100
          )
          $scope.next_level = level.meta.next
          $scope.points_left = parseInt(level.meta.high) - parseInt($scope.points)
        # Set Achievements
        $scope.achievements = []
        achievements = _.find(player.scores, (score) -> score.metric.id is 'achievements')
        for achievement, data of achievements.value
          $scope.achievements.push {
            name: achievement
            description: data.description
          }

      , true)
    ]

    # Load the leaderboard
    $scope.leaderboardLoad = () ->
      API.leaderboardGet({
        metric_id: 'points'
        skip: 0
        limit: 10
      }, (leaderboard) ->
        $scope.leaderboard = leaderboard
        return
      )

    $scope.$on '$destroy', ->
      _.forEach(watchers, (cleanupWatcher) -> cleanupWatcher())
      return
]
