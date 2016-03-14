database = require '../database'

pointsDAO =
  insert: (point) ->
    return new Promise (resolve, reject) ->
      database()
      .collection 'points'
      .insertOne point, (error, data) ->
        if error
          reject error
        else
          resolve data
  get: (query) ->
    return new Promise (resolve) ->
      cursor = database()
      .collection 'points'
      .find query
      resolve cursor.toArray()

module.exports = pointsDAO