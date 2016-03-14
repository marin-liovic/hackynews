express = require 'express'
router = express.Router()
controller = require './thanks_controller'

router.get '/thanks', controller.getThanks

module.exports = router