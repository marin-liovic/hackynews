express = require 'express'
router = express.Router()
controller = require './logout_controller'
authorize = require('../utils/authorization_utils').authorize

router.get '/logout', authorize, controller.getLogout

module.exports = router