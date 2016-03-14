_ = require 'lodash'
errors = require 'restify-errors'
newsModel = require './news_model'
newsDAO = require './news_dao'
newsView = require './news_view'
pointsDAO = require '../points/points_dao'
pointsModel = require '../points/points_model'
pointsUtils = require '../points/points_utils'
commentsDAO = require '../comments/comments_dao'
commentsModel = require '../comments/comments_model'
commentsView = require '../comments/comments_view'
normalizeItems = newsView.normalizeItems
normalizeItem = newsView.normalizeItem

newsController =
  getNews: (req, res, next) ->
    newsDAO
    .getTop()
    .then pointsUtils.getPointsMixinForUser req.session.user && req.session.user.username
    .then (data) ->
      res.render 'news', {
        news: normalizeItems data.news
        path: '/news'
        points: data.points
      }
      next()
  postNews: (req, res, next) ->
    data = req.body
    data.author = req.session.user.username
    newsDAO
    .insert newsModel.create data
    .then ->
      res.redirect '/thanks'
      next()
  getItem: (req, res, next) ->
    id = req.params.id
    newsDAO
    .getById id
    .then (news) ->
      Promise.all [
        (pointsUtils.getPointsMixinForUser req.session.user && req.session.user.username) news
        commentsDAO.getByItemId id
      ]
    .then (results) ->
      data = results[0]
      data.comments = results[1]
      item = data.news[0]
      res.render 'item', {
        item: normalizeItem item
        path: '/news/' + item._id
        points: data.points
        comments: commentsView.normalizeComments data.comments
      }
      next()
  postItemPoint: (req, res, next) ->
    pointsDAO.get {
      author: req.session.user && req.session.user.username
      itemId: req.params.id
    }
    .then (points) ->
      if not _.isEmpty(points)
        throw next new errors.ConflictError 'You have already upvoted this item'
      else
        newsDAO.getById req.params.id
    .then (news) ->
      item = news[0]
      if item?
        item.points++
        newsDAO.update item
    .then ->
      pointsDAO.insert pointsModel.create {
        itemId: req.params.id
        author: req.session.user.username
      }
    .then ->
      res.redirect req.query.goto || '/news'
      next()
  postItemComments: (req, res, next) ->
    data = req.body
    data.itemId = req.params.id
    data.author = req.session.user.username
    commentsDAO
    .insert commentsModel.create data
    .then ->
      res.redirect '/news/' + req.params.id
      next()

module.exports = newsController