_ = require 'lodash'
pointsDAO = require './points_dao'

pointsUtils =
  getPointsMixinForUser: (username) ->
      (news) ->
        if username?
          promise = pointsDAO.get
            author: username
            itemId:
              $in: _.map news, (item) -> item._id.toString()
         else
          promise = Promise.resolve []
        promise
        .then (points) ->
          points: _.map points, 'itemId'
          news: news

module.exports = pointsUtils