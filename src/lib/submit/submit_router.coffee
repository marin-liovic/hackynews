express = require 'express'
router = express.Router()
controller = require './submit_controller'
authorize = require('../utils/authorization_utils').authorize

router.get '/submit', authorize, controller.getSubmit

module.exports = router