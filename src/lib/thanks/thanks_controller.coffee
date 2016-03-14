thanksController =
  getThanks: (req, res, next) ->
    res.render 'thanks'
    next()

module.exports = thanksController