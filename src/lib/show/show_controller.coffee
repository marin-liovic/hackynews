newsDAO = require '../news/news_dao'
newsView = require '../news/news_view'
pointsUtils = require '../points/points_utils'
normalizeItems = newsView.normalizeItems

showController =
  getShow: (req, res, next)->
    newsDAO
    .getShow()
    .then pointsUtils.getPointsMixinForUser req.session.user && req.session.user.username
    .then (data) ->
      res.render 'show', {
        news: normalizeItems data.news
        path: '/show'
        points: data.points
      }
      next()

module.exports = showController