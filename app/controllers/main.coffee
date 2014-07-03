_ = require 'lodash'

module.exports = [
  '$rootScope', '$scope', 'API', 'Profile', '$timeout', '$sce', '$http'
  ($rootScope ,  $scope ,  API ,  Profile,   $timeout,   $sce ,  $http) ->
    $scope.logged_in = false
    $scope.register_user = false

    $scope.login = ->
      $http.post('/login',{
        player_id: $scope.user_name
      })
      .success (data, status, headers, config) ->
        $scope.logged_in = true
        $rootScope.$broadcast 'player.load'
      .error (data, status, headers, config) ->
        $scope.login_status = "Invalid ID"
        return
      return

    $scope.userRegister = ->
      $scope.register_user = true
      return

    $scope.userLogin = ->
      $scope.register_user = false
      return

    $scope.register = ->
      if $scope.new_user_id?
        fixed_user_name = $scope.new_user_id.replace(/([a-z\d])([A-Z]+)/g, '$1_$2')
                    .replace(/[-\s]+/g, '_')
                    .replace(/[^A-Za-z0-9_-]/g,'')
                    .toLowerCase()
        $http.post('/register', {
          id: fixed_user_name
          alias: $scope.new_user_id
        })
        .success (data, status, headers , config) ->
          $scope.login_status = "Registration successful"
          $scope.register_user = false
          return
        .error (data, status, headers , config) ->
          $scope.reg_status = "Invalid ID"
          return
      return

    $scope.queueNotification = (notification) ->
      $rootScope.notifications.push notification
      # Set up notification clear timeout
      $timeout( ->
        $rootScope.notifications.shift()
        return
      , 5000)

    # Push notifications into queue
    $scope.notificationHandler = (notification) ->
      data = null
      switch notification.event
        when 'progress'
          score = _.find(notification.changes, (change) -> change.metric.id is 'points')
          return unless score?
          data = {
            player_id: $rootScope.player.id
            message: $sce.trustAsHtml("You just earned <strong>#{parseInt(score.delta.new) - parseInt(score.delta.old)}</strong> points !")
          }
        when 'achievement'
          achievement = _.find(notification.changes, (change) -> change.metric.id is 'achievements')
          return unless achievement?
          badge = _.keys(achievement.delta)[0]
          data = {
            badge: badge
            player_id: $rootScope.player.id
            message: $sce.trustAsHtml("You just earned the <strong>#{badge}</strong> badge !")
          }
        when 'level'
          level = _.find(notification.changes, (change) -> change.metric.id is 'level')
          return unless level?
          data = {
            player_id: $rootScope.player.id
            message: $sce.trustAsHtml("You attained <strong>#{level.delta.new}</strong> level")
          }

      if data then $scope.queueNotification(data)
      return

    # Fetch Player Activity log
    $scope.profileActivityQuery = (args) ->
      $rootScope.activities ?= []

      if args?.data?.end?
        end = args.data.end
      else
        end = _.last($rootScope.activities)?.timestamp
        end = if end? then new Date(end) else new Date()
      start = new Date(end.getTime() - 24*60*60*1000)

      API.playerActivityQuery({
        start: start.getTime(),
        end: end.getTime()
      }, ({ data: response }) ->
        # The response is either an Array (if the source is not
        # exhausted yet), or a "null" string literal (if exhausted).
        if _.isArray(response)
          response = _.filter(_.map(response, $scope.parseActivity).reverse(), (activity) -> activity.story? )
          # Logs are in reverse order of recency, so prepend the logs
          # rather than appending them, and also display in reverse.
          unless response.length is 0
            Array::push.apply $rootScope.activities, response

        return
        )

    $scope.parseActivity = (activity) ->
      switch activity.event
        when 'progress'
          score = _.find(activity.changes, (change) -> change.metric.id is 'points')
          return {} unless score?
          if score?
            delta = parseInt(score.delta.new) - parseInt(score.delta.old)
            switch activity.activity.id
              when 'like'
                story = $sce.trustAsHtml("You earned <strong>#{delta}</strong> points for <strong>liking a post</strong>")
              when 'watch_video'
                story = $sce.trustAsHtml("You earned <strong>#{delta}</strong> points for <strong>watching a video</strong>")
              when 'share'
                story = $sce.trustAsHtml("You earned <strong>#{delta}</strong> points for <strong>sharing a post</strong>")
              when 'tweet'
                story = $sce.trustAsHtml("You earned <strong>#{delta}</strong> points for <strong>tweeting about a post</strong>")
              when 'dice_roll'
                story = $sce.trustAsHtml("Its your lucky day! Your got <strong>#{delta}</strong> points!")
          else story = null
        when 'level'
          level = _.find(activity.changes, (change) -> change.metric.id is 'level')
          return {} unless level?
          story = $sce.trustAsHtml("You attained <strong>#{level.delta.new}</strong> level")
        when 'achievement'
          achievement = _.find(activity.changes, (change) -> change.metric.id is 'achievements')
          return {} unless achievement?
          badge = _.keys(achievement.delta)[0]
          story = $sce.trustAsHtml("You earned the <strong>#{badge}</strong> badge !")

      {
        badge: badge
        story: story
        timestamp: new Date(activity.timestamp)
      }


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
          $scope.profileActivityQuery()
          return
        )
      )
      $rootScope.$on('player.activity.update', (event, activities) ->
        activities = _.filter(_.map(activities, $scope.parseActivity).reverse(), (activity) -> activity.story?)
        Array::unshift.apply $rootScope.activities, activities
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
