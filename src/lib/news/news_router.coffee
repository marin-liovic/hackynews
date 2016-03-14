express = require 'express'
router = express.Router()
controller = require './news_controller'
authorize = require('../utils/authorization_utils').authorize

router.get '/', controller.getNews
router.get '/news', controller.getNews
router.post '/news', authorize, controller.postNews
router.get '/news/:id', controller.getItem
router.post '/news/:id/point', authorize, controller.postItemPoint
router.post '/news/:id/comments', authorize, controller.postItemComments

module.exports = router