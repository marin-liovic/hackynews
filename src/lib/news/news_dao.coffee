database = require '../database'
ObjectID = (require 'mongodb').ObjectID
newsModel = require './news_model'
DEFAULT_FIND = {}
DEFAULT_LIMIT = 20
DEFAULT_SORT = {}

getFromDatabase = (options) ->
  return new Promise (resolve) ->
    cursor = database()
    .collection 'news'
    .find options.find || DEFAULT_FIND
    .limit options.limit || DEFAULT_LIMIT
    .sort options.sort || DEFAULT_SORT
    resolve cursor.toArray()

newsDAO =
  getById: (id) ->
    return getFromDatabase
      find:
        _id: ObjectID(id)
      limit: 1
  getTop: () ->
    return getFromDatabase
      sort:
        points: -1
  getNewest: () ->
    return getFromDatabase
      sort:
        createdOn: -1
  getShow: () ->
    return getFromDatabase
      find:
        title: RegExp "^#{newsModel.SHOW_TITLE}"
      sort:
        points: -1
  getAsk: () ->
    return getFromDatabase
      find:
        title: RegExp "^#{newsModel.ASK_TITLE}"
      sort:
        points: -1
  insert: (item) ->
    return new Promise (resolve, reject) ->
      database()
      .collection 'news'
      .insertOne item, (error, data) ->
        if error
          reject error
        else
          resolve data
  update: (item) ->
    return new Promise (resolve, reject) ->
      database()
      .collection 'news'
      .update {_id: item._id}, item
      .then (data) ->
        result = data.result
        if (result.ok)
          resolve()
        else
          reject()

module.exports = newsDAO