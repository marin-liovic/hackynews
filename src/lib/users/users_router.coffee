express = require 'express'
router = express.Router()
controller = require './users_controller'

router.post '/users', controller.postUsers

module.exports = router