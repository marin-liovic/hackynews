express = require 'express'
router = express.Router()
controller = require './ask_controller'

router.get '/ask', controller.getAsk

module.exports = router