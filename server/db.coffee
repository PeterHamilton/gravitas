mongoose = require 'mongoose'
{log, dir} = require './common/utils'
# TODO put config this into common
config = require('../config').config


MONGO_URL = 'mongodb://localhost/gravitas'


# Models

User = mongoose.model 'User', new mongoose.Schema
  id: mongoose.Schema.ObjectId
  username:
    type: String
    index: true
  password: String


connect = ->
  mongoose.connect MONGO_URL


setup = (callback) ->
  User.remove {}, (e) ->
    log "dropped all users"

    for name, pw of config.default_users
      log "inserting user: #{name}"
      user = new User
        username: name
        password: pw
      user.save callback


configureRoutes = (app) ->
  app.get "/gravitas/all", (req, res, next) ->
    collection.find().toArray (err, results) ->
      console.dir results
      res.send JSON.stringify(results)

  app.get "/gravitas/get/:id?", (req, res, next) ->
    id = req.params.id
    if id
      console.log "get id:", id
      collection.find({id: id}, {limit: 1}).toArray (err, voc) ->
        console.dir voc[0]
        res.send JSON.stringify(voc[0])
    else
      next()

  app.post "/gravitas/put/", (req, res) ->
    obj = req.body
    collection.update { uid: obj.uid }, obj, { upsert: true }
    res.send req.body


exports.MONGO_URL = MONGO_URL
exports.User = User
exports.connect = connect
exports.setup = setup
exports.configureRoutes = configureRoutes
