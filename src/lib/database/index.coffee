MongoClient = require('mongodb').MongoClient
CONFIG = require '../../config/database.json'
database = null

MongoClient.connect CONFIG.url, (err, db) ->
  if err
    console.log err
    throw err
  else
    database = db

module.exports = () -> database

