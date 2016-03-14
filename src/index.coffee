express = require 'express'
session = require 'express-session'
bodyParser = require 'body-parser'
errors = require 'restify-errors'
app = express()
PORT = process.env.PORT || 3000

app.set('view engine', 'jade')
app.set('views', './views')

app.use express.static(__dirname + '/../public')
app.use bodyParser.json()
app.use bodyParser.urlencoded {extended: true}
app.use session {
  secret: 'wow_such_secret_much_security_helvetica'
  resave: false
  saveUninitialized: true
}
app.use (req, res, next) ->
  res.locals.user = req.session.user
  next()

app.use require './lib/news/news_router'
app.use require './lib/submit/submit_router'
app.use require './lib/logout/logout_router'
app.use require './lib/thanks/thanks_router'
app.use require './lib/newest/newest_router'
app.use require './lib/show/show_router'
app.use require './lib/ask/ask_router'
app.use require './lib/login/login_router'
app.use require './lib/users/users_router'

app.use (err, req, res, next) ->
  res.status err.statusCode || 500
  res.render 'error', { error: err.message || err }

app.listen PORT,  -> console.log "Hacky News listening on port #{PORT}"