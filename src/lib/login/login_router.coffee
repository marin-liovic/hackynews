express = require 'express'
router = express.Router()
controller = require './login_controller'

router.get '/login', controller.getLogin
router.post '/login', controller.postLogin

module.exports = router