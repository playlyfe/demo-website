module.exports = [
  '$rootScope', '$scope', 'API'
  ($rootScope ,  $scope ,  API) ->

    $scope.interact = (interaction) ->
      API.processPlay({
        process_owner: $rootScope.player.id
        process_id: "bs_2iiavk"
      }, {
        trigger: interaction
      }, (result) ->
        $rootScope.$broadcast('player.refresh')
      )

]
