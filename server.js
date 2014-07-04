express = require('express');
sockjs = require('sockjs');
request = require('request');
cookieParser = require('cookie-parser');
cookieSession = require('cookie-session');
logger = require('morgan');
errorhandler = require('errorhandler');
bodyParser = require('body-parser');
_ = require('lodash');


// Put in your application details here.
var config = require('./config');
oauth = require('simple-oauth2')(config.client);

var token = {};

app = express();
app.use(cookieParser());
app.use(bodyParser.urlencoded({extended: true}));
app.use(bodyParser.json());
app.use(cookieSession({ secret: 'TOP_SECRET', cookie: { domain: 'localhost'} }));
app.use(express.static(__dirname+"/public"));
app.use(logger());
app.use(errorhandler());
app.set('views', "" + __dirname + "/views");
app.set('view engine', 'jade');

var getToken = function (callback) {
  if (_.isEmpty(token) || token.expired()) {
    oauth.Client.getToken({}, function(err, data) {
      if(err) {
        callback(err, null);
        return;
      }
      token = oauth.AccessToken.create(data);
      callback(null, token);
    });
  }
};

var authApi = function (req, res, next) {
  if (req.session.logged_in && req.session.auth != null) {
    if (_.isEmpty(token) || token.expired()) {
      getToken(function (err, result) {
        if(err) {
          return res.json(500, {
            error: 'server_error',
            error_description: err.message || "Poof"
          });
        }
        next();
      });
    }
  } else {
    return res.json(401, {
      error: 'access_denied',
      error_description: 'You are not authorized on this site'
    });
  }
};

// Proxy requests to playlyfe server.
var proxyApi = function(req, res) {
  try {
    res.header("Cache-Control", "no-cache, no-store, must-revalidate");
    res.header("Pragma", "no-cache");
    res.header("Expires", 0);

    req.query.access_token = token.token.access_token;
    if(req.session.auth) {
      if(req.session.auth.player_id) {
        req.query.player_id = req.session.auth.player_id;
      }
    }

    // uncomment this when the game is in staging
    req.query.debug = true;

    endpoint = 'http://api.playlyfe.com/v1';
    url = endpoint+'/'+(req.params[0] != null ? req.params[0] : '');

    request({
      url: url,
      method: req.method.toUpperCase(),
      qs: req.query,
      headers:{
        'Content-Type': 'application/json'
      },
      body: JSON.stringify(req.body),
      encoding: null,
    }, function(err, response, body) {
        if (err) throw err;
        res.statusCode = response.statusCode;
        for (var header in response.headers) {
          res.header(header, response.headers[header]);
        }
        res.end(body);
      });
  } catch (e) {
    res.json(500, {
      error: "server_error",
      error_description: e.message
    });
  }
};

app.get('/api', authApi, proxyApi);
app.all('/api/*', authApi, proxyApi);

app.post('/login', function(req, res) {
  req.session.logged_in = true;
  req.session.auth = {
    player_id : req.body.player_id
  };

  req.session.auth.player_id = req.body.player_id;
  req.params[0] = 'player';
  req.method = 'GET';
  proxyApi(req, res);
});

app.post('/register', function(req, res) {
  req.params[0]='players';
  proxyApi(req, res);
});

app.get('/logout', function (req, res) {
  req.session.logged_in = false;
  delete req.session.auth;
  res.redirect('/');
});

app.get('/', function(req, res) {
  return res.render('index.jade', config.app);
});

app.listen(3001, function(err) {
  if (err) throw err;
  getToken(function(err, data) {
    if (data) {
      console.log("Server up");
    } else {
      console.log("There was an error", err);
      process.exit();
    }
  });
});
