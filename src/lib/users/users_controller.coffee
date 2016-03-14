errors = require 'restify-errors'
usersModel = require './users_model'
usersDAO = require './users_dao'

usersController =
  postUsers: (req, res, next) ->
    username = req.body.username
    return usersDAO.getByUsername(username)
    .then (user) ->
      if user?
        throw next new errors.ConflictError "User with username \"#{username}\" already exists."
      else
        return usersDAO.insert usersModel.create req.body
    .then (result) ->
      req.session.user = result.ops[0]
      res.redirect '/news'
      next()

module.exports = usersController