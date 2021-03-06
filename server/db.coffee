mongoose = require 'mongoose'
{log, dir} = require './common/utils'
# TODO put config this into common
config = require('../config').config


MONGO_URL = 'mongodb://localhost/gravitas'


# Models

Achievement_schema = new mongoose.Schema(
  id: Number
  date: String
)

RatingHistory_schema = new mongoose.Schema(
  rating: Number
)


User = mongoose.model 'User', new mongoose.Schema
  id: mongoose.Schema.ObjectId
  username:
    type: String
    index: true
  password: String
  avatarURL: String
  timePlayed_s: Number
  gamesPlayed: Number
  gamesWon: Number
  gamesLost: Number
  rating: Number
  achievements: [ Achievement_schema ]
  ratingHistory: [ RatingHistory_schema ]


connect = (errfn) ->
  mongoose.connect MONGO_URL

  mongoose.connection.on 'error', (err) ->
    if errfn
      errfn err
    else
      # Make sure that the exception is shown at least
      # somewhere if there is no error handler.
      throw err


setup = (callback) ->
  User.remove {}, (e) ->
    log "dropped all users"

    for name, details of config.default_users
      log "inserting user: #{name}"
      user = new User
        username: name
        password: details.pass
        avatarURL: details.avatar
        timePlayed_s: 39603
        gamesPlayed: 70
        gamesWon: 31
        gamesLost: 25
        rating: (Math.floor(Math.random() * 1700)) + 500  # min: 500, max: 1700 + 500 = 2200
        achievements: [
          {id : 0, date : "12.03.2012"}
          {id : 1, date : "14.03.2012"}
          {id : 2, date : ""}
          {id : 3, date : ""}
          {id : 4, date : ""}
        ]
        ratingHistory: [
          {rating : 123}
          {rating : 456}
          {rating : 789}
          {rating : 546}
          {rating : 1123}
          {rating : 1000}
        ]
      user.save callback


exports.MONGO_URL = MONGO_URL
exports.User = User
exports.connect = connect
exports.setup = setup
