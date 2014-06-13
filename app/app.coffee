angular = require 'angular'
require 'angular-resource'
require 'angular-moment'

app = angular.module('plDemo', ['ngResource', 'angularMoment'])


app.provider('Playlyfe', require('./services/playlyfe'))
app.controller('MainCtrl', require('./controllers/main'))
app.controller('InteractionCtrl', require('./controllers/interaction'))
app.controller('ProfileCtrl', require('./controllers/profile'))
app.service('API', require('./services/api'))
app.service('Profile', require('./services/profile'))

# Pick up the app configuration data from root node
root = angular.element('html')
# GameId and GameEnv are used to setup the API and notification clients
app.constant('GameId', root.attr('data-game'))
app.constant('GameEnv', root.attr('data-env'))
# ProcessId is used to direct all interactions (triggers) to
# this process instance. See `app/controllers/interaction.coffee`.
app.constant('ProcessId', root.attr('data-process'))

# Configure app
app.config([
  'PlaylyfeProvider'
  (PlaylyfeProvider) ->
    PlaylyfeProvider.setVersion('')
    PlaylyfeProvider.setEndpoint('/api')
])
