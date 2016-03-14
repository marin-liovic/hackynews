newsDAO = require '../news/news_dao'
newsView = require '../news/news_view'
pointsUtils = require '../points/points_utils'
normalizeItems = newsView.normalizeItems

newestController =
  getNewest: (req, res, next)->
    newsDAO
    .getNewest()
    .then pointsUtils.getPointsMixinForUser req.session.user && req.session.user.username
    .then (data) ->
      res.render 'newest', {
        news: normalizeItems data.news
        path: '/newest'
        points: data.points
      }
      next()

module.exports = newestController