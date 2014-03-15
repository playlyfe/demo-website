_ = require 'lodash'
SockJS = require 'sockjs'

module.exports = [
  () ->
    @version = '/v1'
    @endpoint = "http://api.playlyfe.com"
    @$get =[
      '$resource',
      ($resource) =>
        (game_id, environment) =>

          base_url = "#{@endpoint}#{@version}"
          client = $resource("#{base_url}", {}, {
            statusGet: {
              url: "#{base_url}/"
              method: "GET"
            }
            playerGet: {
              url: "#{base_url}/player"
              method: "GET"
            }
            processPlay: {
              url: "#{base_url}/processes/:process_owner/:process_id/play"
              method: "POST"
              transformResponse: (data, headersGetter) ->
                if /application\/json/.test(headersGetter('content-type'))
                  data = JSON.parse(data)
                  if _.isArray(data)
                    {
                      triggers: data[0]
                      scores: data[1]
                      logs: data[2]
                    }
                  else data
                else null
            }
            leaderboardGet: {
              url: "#{base_url}/metrics/:metric_id"
              method: "GET"
              isArray: "true"
            }
            notificationStream: {
              url: "#{base_url}/notifications/token"
              method: "GET"
              transformResponse: (data, headersGetter) =>
                if /application\/json/.test(headersGetter('content-type'))
                  data = JSON.parse(data)
                  client.stream = new SockJS("http://api.playlyfe.com/v1/notifications/stream")

                  # Authethication protocol
                  streamAuth = (message) =>
                    switch message.data
                      when 'AUTH_CHALLENGE'
                        client.stream.send("AUTH_RESPONSE #{data.token} player #{environment} #{game_id} #{client.player_id}")
                      when 'AUTH_SUCCESS'
                        console.log("Successfully opened notification stream for player #{client.player_id}")
                      when 'AUTH_FAILED'
                        console.log("Failed to open notification stream for player #{client.player_id}")
                      else
                        client.notificationHandler(JSON.parse(message.data.slice(message.data.indexOf(' '))))
                    return

                  client.stream.onmessage = streamAuth

                  data



                else null
            }
          })

          client.player_id = null
          client.notificationHandler = (notification) -> console.log notification
          client.stream = null

          client
    ]

    @setVersion = (version) =>
      @version = version
      return

    @setEndpoint = (endpoint) =>
      @endpoint = endpoint
      return

    @setEnvironment = (environment) =>
      @environment = environment
      return

    return
]
