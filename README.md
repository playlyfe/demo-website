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
      - Loop Count: ∞ (Infinity)
      - +5 Points
      - +1 Like
      - Recurring (found in the <kbd>Score</kbd> tab, under *More Options*)
      - Rate Limit: 5 Times in an Hour

    + **Share**
      - Task ID: share
      - Loop Count: ∞ (Infinity)
      - +10 Points
      - Recurring
      - +1 Share
      - Rate Limit: 3 Times in 24 Hours

    + **Tweet**
      - Task ID: tweet
      - Loop Count: ∞ (Infinity)
      - +5 Points
      - Recurring
      - +1 Tweet
      - Rate Limit: 1 Time in an Hour

    + **Watch a Video**
      - Task ID: watch_video
      - Loop Count: ∞ (Infinity)
      - +15 Points
      - Recurring
      - +1 Video
      - Rate Limit: None

    + **Roll a Dice**
      - Task ID: dice_roll
      - Loop Count: ∞ (Infinity)
      - +30 Point 20% of the Time
      - Recurring
      - Rate Limit: 10 Times in an Hour


#### Rules

  1. **Level**

    This rule determines the level of a player.

    |   | Level               | Range            |
    |---|---------------------|------------------|
    | 1 | Zinc                | 0 - 100          |
    | 1 | Bronze              | 100 - 250        |
    | 1 | Silver              | 250 - 500        |
    | 1 | Gold                | 500 - 1000       |
    | 1 | Platinum            | 1000 - Infinity  |


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

### 2. Setup Bootstrap

Once you've got your design ready, you have an option to **Bootstrap** the game. Bootstrapping means that you can:

  - Define the **initial scores** and **badges** each player should start with.

  - Start **process instances** which would show up by default in each player's list of available tasks.

  - Create **teams** which every player will be a part of.

  - Define **roles** which each player will get in each of the teams created above.

In this demo, each player who logs in should have all the tasks *(Like, Share, ...)* available to him from the start. For this, we need to bootstrap an instance of this process.

To do this, go to <kbd>Menu</kbd> <kbd>></kbd> <kbd>Settings</kbd> <kbd>></kbd> <kbd>Game Config</kbd> and select the <kbd>Game Bootstrap</kbd> option in the sidebar.

  Once there, head to the <kbd>Player Processes</kbd> tab, and **Add** a new process. Select the process definition you just created, and give a simple name to it. The **ID** of the process instance will be shown in the next field, which you need to take note of for future purposes.

Once you're done, click **Save** to save this bootstrap data.

**NOTE**: Updating the bootstrap data will **not** affect any old dummy players you had created. Therefore, whenever you are simulating the game after an update (such as updating scores for tasks, updating bootstrap, etc.), create a new dummy player.


### 3. Create a Client

  - Go to <kbd>Menu</kbd> <kbd>></kbd> <kbd>Settings</kbd> <kbd>></kbd> <kbd>Clients</kbd>

  - Create a new client of type **White Label**

  - Click the Test Client check box. Test clients can be used during development to test your game.

### 4. Simulate your game

  - Go to <kbd>Launcher</kbd> <kbd>></kbd> <kbd>Simulate</kbd> and simulate your game.

**NOTE**: Each time you make a change in the game design, you have to simulate the game.


### 5. Setup Demo on your machine

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

  - Rename the **config.sample.js** file in the root folder to **config.js**, and configure it as below.

    ```
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

        site: 'http://playlyfe.com',

        tokenPath: '/auth/token',
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


## Known Issues

There is a known issue with Google Chrome, wherein the session cookies are not being set in the browser. We will be fixing it in the next version, until then you can use Firefox for your development purposes.

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
