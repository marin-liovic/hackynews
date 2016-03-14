submitController =
  getSubmit: (req, res, next) ->
    res.render 'submit'
    next()

module.exports = submitController