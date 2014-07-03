// config.js
module.exports = {
  /**
   * Configuration for the client.
   * This governs how your app connects to the Playlyfe servers.
   */
  client: {
    /**
     * ID of the client you create.
     */
    clientID: '<YOUR TEST CLIENT ID>',
    /**
     * Client Secret of the client you create.
     */
    clientSecret: '<YOUR CLIENT SECRET>',
    /**
     * The website for fetching the token
     */
    site: 'http://playlyfe.com',
    /**
     * The path to fetch the token from
     */
    tokenPath: '/auth/token'
    /** In case you are behind a proxy, uncomment the next line and
     * add the relevant credentials and host-name:port here.
     */
    // proxy: 'http://<YOUR_USERNAME:YOUR_PASSWORD>@<HTTP_PROXY_HOST>:<PROXY_PORT>'
  },
  /**
   * Configuration for the app.
   * This is used by the Angularjs frontend app for making REST calls and
   * opening sockets for notifications.
   */
  app: {
    /**
     * The ID of your game
     */
    game_id: '<YOUR GAME ID>',
    /**
     * The environment you are running your app in ('production'|'staging')
     * Defaults to 'production'
     * Use 'staging' while developing/testing the app
     */
    environment: 'production',
    /**
     * The ID of the process instance you are using for this app.
     * Get this from the Bootstrap screen of the game.
     */
    process_id: '<ID OF THE BOOTSTRAPPED PROCESS>'
  }
};
