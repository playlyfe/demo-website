module.exports = [
  '$rootScope', '$scope', 'API', 'ProcessId', '$sce'
  ($rootScope ,  $scope ,  API ,  ProcessId, $sce) ->

    $scope.interact = (interaction) ->
      API.processPlay({
        process_owner: $rootScope.player.id
        process_id: ProcessId
      }, {
        trigger: interaction
      }, (result) ->
        $rootScope.$broadcast('player.refresh')
        $rootScope.$broadcast('player.activity.update', result.logs.local.concat(result.logs.global))
      , (result) ->
        if result.status is 503
          $scope.queueNotification({
            timeout: true
            player_id: $rootScope.player.id
            message: $sce.trustAsHtml("You need to wait a while before you can get points for this action again")
          })
      )

]
