express = require 'express'
router = express.Router()
controller = require './newest_controller'

router.get '/newest', controller.getNewest

module.exports = router