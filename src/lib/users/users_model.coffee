bcrypt = require 'bcrypt'

usersModel =
  create: (data) ->
    username: data.username
    password: bcrypt.hashSync data.password, 10
    createdOn: new Date()

module.exports = usersModel