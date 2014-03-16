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

# Configure app
app.config([
  'PlaylyfeProvider'
  (PlaylyfeProvider) ->
    PlaylyfeProvider.setVersion('')
    PlaylyfeProvider.setEndpoint('/api')
])
