Playlyfe Website Demo
=====================

This is a sample of how Playlyfe can be integrated into a Website.

You can see a working example of this demo [here](http://demo.playlyfe.com)

##Setup Instructions

### 1. Create a Game

You need to frist create the gamified system which will act as the backend for the app.
For more details on how you design a game in Playlyfe check out our [Getting Started Manual](http://dev.playlyfe.com/docs/getting-started).
In this demo we create a simple game which consists of the following components:

#### Metrics

  1. **Points**

    type: Point Metric
    minimum: 0
    maximum: Infinity
    description: A measure of the players contributions

  2. **Levels**

    type: State Metric
    description: A reprentation of the user's status on the website
    states:
      - Zinc
      - Bronze
      - Silver
      - Gold 
      - Platinum
      - Diamond

  3. **Achievements**

    type: Set Metric
    description: The set of achievements that a user earns.
    items:
      - Like at First Sight
      - Liker Lord
      - Share Khan
      - Tweety
      - Tweet Your Heart Out
      - Vid Kid
      - Video Watch Dog

  4. **Like**

    type: Point Metric
    minimum: 0
    maximum: Infinity
    description: The number of like a player performs

  5. **Share**

    type: Point Metric
    minimum: 0
    maximum: Infinity
    description: The number of shares a player performs

  6. **Tweet**

    type: Point Metric
    minimum: 0
    maximum: Infinity
    description: The number of tweets a player does

  7. **Video**

    type: Point Metric
    minimum: 0
    maximum: Infinity
    description: The number of videos the player sees

#### Processes

  1. **User Flow**

    This process represents the users basic flow. It is a simple process with 6 tasks specified below. 
    
    **List of Tasks**
    
    - **Like**
      +5 Points
      +1 Like
      Rate Limit: 5 Times in an Hour
      Task ID: like
      
    - **Share**
      +10 Points
      +1 Share
      Rate Limit: 3 Times in 24 Hours
      Task ID: share
    
    - **Tweet**
      +5 Points
      +1 Tweet
      Rate Limit: 1 Time in an Hour
      Task ID: tweet
    
    - **Watch a Video**
      +15 Points
      +1 Video
      Rate Limit: None
      Task ID: watch_video
    
    - **Roll a Dice**
      +30 Point 20% of the Time
      Rate Limit: 10 Times in an Hour
      Task ID: dice_roll
    

#### Rules
  
  1. **Level**
    
    This rule determines the level of a player.
    
    <table>
          <thead>
            <tr>
              <th></th>
              <th>Level</th>
              <th>Range</th>
            </tr>
          </thead>
          <tbody>
            <tr>
              <td>1</td>
              <td>
                <strong>Zinc</strong>
              </td>
              <td>
                0 – 100
              </td>
            </tr>
            <tr>
              <td>2</td>
              <td>
                <strong>Bronze</strong>
              </td>
              <td>
                100 – 250
              </td>
            </tr>
            <tr>
              <td>3</td>
              <td>
                <strong>Silver</strong>
              </td>
              <td>
                250 – 500
              </td>
            </tr>
            <tr>
              <td>4</td>
              <td>
                <strong>Gold</strong>
              </td>
              <td>
                500 – 1000
              </td>
            </tr>
            <tr>
              <td>5</td>
              <td>
                <strong>Platinum</strong>
              </td>
              <td>
                1000 – Infinity
              </td>
            </tr>
          </tbody>
        </table>

  2. **Vid Kid**
    
    This rule awards the Vid Kid Achievement if the player watches atleast 1 video

  3. **Video Watch Dog**

    This rule awards the Video Watch Dog Achievement if the player watches 10 videos
  
  4. **Tweety**
 
    This rule awards the Tweety Achievement if the player tweets once

  5. **Tweet Your Heart Out**

    This rule awards the Tweet Your Heart Out Achievement if the player tweets 20 times

  6. **Share Khan**

    This rule awards the Share Khan Achievement if the player shares 20 times
  
  7. **Like at First Sight**
    
    This rule awards the Like at First Sight Achievement if the player performs a like 1 time
  
  8. **Liker Lord**
  
    This rule awards the Liker Lord Achievement if the player performs a like atleast 20 times
            

### 2. Create a Client

  - Go to Menu > Settings > Clients
  
  - Create a client with type backend and redirect `http://localhost:3001/auth/redirect`

  - Click the Test Client check box. Test clients can be used during development to test your game.

### 3. Simulate your game

  - Go to Launcher > Simulate and simulate your game.

  - Open the Simulator and Create a dummy player.
    
    This dummy player will the user who we login as will testing the app in development.
  
    
### 4. Setup Demo on your machine

  - Clone the git repo
    
    ```
    git clone https://github.com/playlyfe/demo-website.git
    ```

  - Install package dependencies
    
    ```
    npm install
    bower install
    ```
  
  - Change the Environment of the Game if you are using a test client
    
    In the file `app/services/api.coffee` change `production` to `staging`.

  - Create a config.js file in the root folder. Copy paste the configuration below.
    
    ```
    // config.js
    module.exports = {
        client_id: 'YOUR TEST CLIENTxports ID',
        client_secret: 'YOUR CLIENT SECRET',
        redirect_uri: 'http://localhost:3001/auth/redirect',
        player_id: 'DUMMY PLAYER ID WHICH YOU CREATED IN STEP 3'
    }
    ```
  
  - Build the Application

    ```
    npm run-script build-dev
    ```

  - Open the Application in your Browser at `http://localhost:3001`
    
## Conclusion

I hope this small sample gives you an idea of what is possible with Playlyfe. Feel free to raise an issue or write to [support@playlyfe.com](mailto:support@playlyfe.com) in case you have any specific types of features you would wish to implement and are not sure how to get it done.
