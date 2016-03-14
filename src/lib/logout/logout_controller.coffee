logoutController =
  getLogout: (req, res, next) ->
    user = req.session.user
    if user?
      req.session.destroy()
    res.redirect req.query.goto || '/news'
    next()

module.exports = logoutController