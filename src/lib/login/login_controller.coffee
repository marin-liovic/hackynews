bcrypt = require 'bcrypt'
errors = require 'restify-errors'
usersDAO = require '../users/users_dao'

loginController =
  getLogin: (req, res, next) ->
    res.render 'login';
    next()
  postLogin: (req, res, next) ->
    usersDAO
    .getByUsername req.body.username
    .then (user) ->
      if user && bcrypt.compareSync req.body.password, user.password
        req.session.user = user
      else
        throw next new errors.BadRequestError 'Wrong username/password'
    .then ->
      res.redirect '/news'
      next()

module.exports = loginController