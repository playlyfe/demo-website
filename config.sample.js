// config.js
module.exports = {
  /**
   * ID of the client you create.
   */
  client_id: '<YOUR TEST CLIENT ID>',
  /**
   * Client Secret of the client you create.
   */
  client_secret: '<YOUR CLIENT SECRET>',
  /**
   * Redirect URI of the client you create.
   */
  redirect_uri: 'http://localhost:3001/auth/redirect',
  /**
   * The ID of the player you create in the Simulator.
   */
  player_id: '<DUMMY PLAYER ID WHICH YOU CREATED IN STEP 3>'
  /** In case you are behind a proxy, uncomment the next line and
   * add the relevant credentials and host-name:port here.
   */
  // proxy: 'http://<YOUR_USERNAME:YOUR_PASSWORD>@<HTTP_PROXY_HOST>:<PROXY_PORT>'
};
