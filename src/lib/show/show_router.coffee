express = require 'express'
router = express.Router()
controller = require './show_controller'

router.get '/show', controller.getShow

module.exports = router