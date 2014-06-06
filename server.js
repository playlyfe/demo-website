express = require('express');
Playlyfe = require('playlyfe-node-sdk');
sockjs = require('sockjs');


// Put in your application details here.
var config = require('./config');

client = new Playlyfe(config);

app = express();
app.use(express.cookieParser());
app.use(express.json());
app.use(express.cookieSession({ secret: 'TOP_SECRET', cookie: { domain: 'localhost' } }));
app.use(express.static(__dirname+"/public"));
app.use(app.router);
app.use(express.logger());
app.use(express.errorHandler());

var auth = function (req, res, next) {
  if (req.session.logged_in && req.session.auth != null) {
    return next();
  } else {
    return res.redirect(client.getAuthorizationURI());
  }
};

var authApi = function (req, res, next) {
  if (req.session.logged_in && req.session.auth != null) {
    var token = req.session.auth;
    if (client.isAccessTokenExpired(token)) {
      client.refreshAccessToken(token, function (err, token) {
        if (err) {
          delete req.session.auth;
          return res.json(400, {
            error: 'access_denied',
            error_description: 'Your authorization attempt failed'
          });
        }
        req.session.auth = token;
        return next();
      });
    } else {
      return next();
    }
  } else {
    return res.json(401, {
      error: 'access_denied',
      error_description: 'You are not authorized to access the API.'
    });
  }
};

var proxyApi = function(req, res) {
  try {
    res.header("Cache-Control", "no-cache, no-store, must-revalidate");
    res.header("Pragma", "no-cache");
    res.header("Expires", 0);
    client.api(
      '/' + (req.params[0] != null ? req.params[0] : ''),
      req.route.method.toUpperCase(),
      { qs: req.query, body: req.body },
      req.session.auth.access_token,
      function(err, response, body) {
        if (err) throw err;
        res.statusCode = response.statusCode
        for (header in response.headers) {
          res.header(header, response.headers[header]);
        }
        res.end(body);
      }
    );
  } catch (e) {
    res.json(500, { error: "server_error", error_description: e.message })
  }
}

// start playlyfe oauth authorization code flow
app.get('/auth', auth, function (req, res) {
  return res.redirect('/');
});

// get access token and save it
app.get('/auth/redirect', function (req, res) {
  if (req.query.code !== null) {
    client.getToken(req.query.code, function(err, token) {
      if (err) return res.json(500, err);
      req.session.auth = token;
      req.session.logged_in = true;
      res.redirect('/');
    });
  } else {
    res.redirect('/');
  }
});



// Proxy requests to playlyfe server.
// We keep the access token away from cheaters by using the authorization code flow.
// This can be integrated with the Playlyfe Javascript SDK to provide secure transparent endpoint for browser clients.


app.all('/api/*', authApi, proxyApi);
app.get('/api', authApi, proxyApi);

app.get('/logout', auth, function (req, res) {
  req.session.logged_in = false;
  delete req.session.auth;
  res.redirect('/');
});

app.listen(3001);
