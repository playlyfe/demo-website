Playlyfe Website Demo
=====================

This is a sample project, which shows you how Playlyfe can be integrated into a Website.

You can see a working example of this demo [here](http://demo.playlyfe.com)

##Setup Instructions

### 1. Create a Game

Firstly, you need to create the gamified system which will act as the backend for the app.
For more details on how you can design a game in Playlyfe, check out our [Getting Started Manual](http://dev.playlyfe.com/docs/getting-started).

In this demo we create a simple game which consists of the following components:

#### Metrics

  1. **Points**
    + type: Point Metric
    + minimum: 0
    + maximum: Infinity
    + description: A measure of the players contributions

  2. **Levels**
    + type: State Metric
    + description: A reprentation of the user's status on the website
    + states:
      + Zinc
      + Bronze
      + Silver
      + Gold
      + Platinum
      + Diamond

  3. **Achievements**
    + type: Set Metric
    + description: The set of achievements that a user earns.
    + items:
      + Like at First Sight
      + Liker Lord
      + Share Khan
      + Tweety
      + Tweet Your Heart Out
      + Vid Kid
      + Video Watch Dog

  4. **Like**
    + type: Point Metric
    + minimum: 0
    + maximum: Infinity
    + description: The number of like a player performs

  5. **Share**
    + type: Point Metric
    + minimum: 0
    + maximum: Infinity
    + description: The number of shares a player performs

  6. **Tweet**
    + type: Point Metric
    + minimum: 0
    + maximum: Infinity
    + description: The number of tweets a player does

  7. **Video**
    + type: Point Metric
    + minimum: 0
    + maximum: Infinity
    + description: The number of videos the player sees

#### Processes

  1. **User Flow**

    This process represents the users basic flow. It is a simple process with 6 tasks specified below.

    **List of Tasks**

    + **Like**
      - Task ID: like
      - +5 Points
      - +1 Like
      - Rate Limit: 5 Times in an Hour

    + **Share**
      - Task ID: share
      - +10 Points
      - +1 Share
      - Rate Limit: 3 Times in 24 Hours

    + **Tweet**
      - Task ID: tweet
      - +5 Points
      - +1 Tweet
      - Rate Limit: 1 Time in an Hour

    + **Watch a Video**
      - Task ID: watch_video
      - +15 Points
      - +1 Video
      - Rate Limit: None

    + **Roll a Dice**
      - Task ID: dice_roll
      - +30 Point 20% of the Time
      - Rate Limit: 10 Times in an Hour


#### Rules

  1. **Level**

    This rule determines the level of a player.

    ----------------------------------------------
    |   | Level               | Range            |
    |---|---------------------|------------------|
    | 1 | Zinc                | 0 - 100          |
    | 1 | Bronze              | 100 - 250        |
    | 1 | Silver              | 250 - 500        |
    | 1 | Gold                | 500 - 1000       |
    | 1 | Platinum            | 1000 - Infinity  |
    ----------------------------------------------

  2. **Vid Kid**

    This rule awards the Vid Kid Achievement if the player watches atleast **1 video**.

  3. **Video Watch Dog**

    This rule awards the Video Watch Dog Achievement if the player watches **10 videos**.

  4. **Tweety**

    This rule awards the Tweety Achievement if the player **tweets once**.

  5. **Tweet Your Heart Out**

    This rule awards the Tweet Your Heart Out Achievement if the player **tweets 20 times**.

  6. **Share Khan**

    This rule awards the Share Khan Achievement if the player **shares 20 times**.

  7. **Like at First Sight**

    This rule awards the Like at First Sight Achievement if the player performs a **like once**.

  8. **Liker Lord**

    This rule awards the Liker Lord Achievement if the player performs a **like atleast 20 times**.


### 2. Create a Client

  - Go to <kbd>Menu</kbd> <kbd>></kbd> <kbd>Settings</kbd> <kbd>></kbd> <kbd>Clients</kbd>

  - Create a client with type backend and redirect `http://localhost:3001/auth/redirect`

  - Click the Test Client check box. Test clients can be used during development to test your game.

### 3. Simulate your game

  - Go to <kbd>Launcher</kbd> <kbd>></kbd> <kbd>Simulate</kbd> and simulate your game.

  - Open the Simulator and Create a dummy player.

    This dummy player will the user who we login as will testing the app in development.


### 4. Setup Demo on your machine

  - Clone the git repo and switch to the folder

    ```
    git clone https://github.com/playlyfe/demo-website.git
    cd demo-website
    ```

  - Install required tools (bower and gulp)

    ```
    npm install -g bower
    npm install -g gulp
    ```

  - Install package dependencies

    ```
    npm install
    bower install
    ```

  - Change the Environment of the Game if you are using a test client

    In the file `app/services/api.coffee` change `production` to `staging`.

  - Rename the config.sample.js file in the root folder, and configure it as below.

    ```
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

    ```

  - Build the Application

    ```
    npm run-script build-dev
    ```

  - Run the Server

    ```
    npm start
    ```

  - Open the Application in your Browser at [http://localhost:3001](http://localhost:3001)

## Conclusion

We hope this small sample gives you an idea of what is possible with Playlyfe.

If you are facing any issue with setting up the code, you can [raise an issue](https://github.com/playlyfe/demo-website/issues).

In case you want guidance on how to implement a feature in your app, write to us at [support@playlyfe.com](mailto:support@playlyfe.com).


-----


## License

The MIT License (MIT)

Copyright (c) 2013 Playlyfe IT Solutions Pvt. Ltd.

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.


###### ![Playlyfe](http://playlyfe.com/favicon.ico) <kbd>PLAYLYFE: THE ONLINE GAMIFICATION PLATFORM</kbd>
