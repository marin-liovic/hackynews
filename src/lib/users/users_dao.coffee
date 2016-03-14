database = require '../database'
ObjectID = (require 'mongodb').ObjectID

usersDao =
  insert: (user) ->
    return new Promise (resolve, reject) ->
      database()
      .collection 'users'
      .insertOne user, (error, data) ->
        if error
          reject error
        else
          resolve data
  getByUsername: (username) ->
    return new Promise (resolve) ->
      cursor = database()
      .collection 'users'
      .find {username: username}
      resolve cursor.toArray()
    .then (results) -> results[0]

module.exports = usersDao