authorizationUtils =
  authorize: (req, res, next) ->
    user = req.session.user
    if not user?
      res.render 'error', {error: "You need to login to access page: #{req.path}"}
    else
      next()

module.exports = authorizationUtils