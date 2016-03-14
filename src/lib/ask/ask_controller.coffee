newsDAO = require '../news/news_dao'
newsView = require '../news/news_view'
pointsUtils = require '../points/points_utils'
normalizeItems = newsView.normalizeItems

askController =
  getAsk: (req, res, next)->
    newsDAO
    .getAsk()
    .then pointsUtils.getPointsMixinForUser req.session.user && req.session.user.username
    .then (data) ->
      res.render 'ask', {
        news: normalizeItems data.news
        path: '/ask'
        points: data.points
      }
      next()

module.exports = askController