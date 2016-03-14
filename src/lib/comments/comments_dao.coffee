database = require '../database'
DEFAULT_LIMIT = 20
DEFAULT_SORT = createdOn: -1

commentsDAO =
  insert: (comment) ->
    return new Promise (resolve, reject) ->
      database()
      .collection 'comments'
      .insertOne comment, (error, data) ->
        if error
          reject error
        else
          resolve data
  getByItemId: (itemId) ->
    return new Promise (resolve) ->
      cursor = database()
      .collection 'comments'
      .find itemId: itemId
      .limit DEFAULT_LIMIT
      .sort createdOn: -1
      resolve cursor.toArray()

module.exports = commentsDAO