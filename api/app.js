'use strict'
let express = require('express')
let logger = require('morgan')
let cookieParser = require('cookie-parser')
let bodyParser = require('body-parser')
const expressJWT = require('express-jwt')
// const path = require('path')

let app = express()
app.disable('x-powered-by')
// view engine setup
app.use(logger('dev'))
app.use(bodyParser.json())
app.use(bodyParser.urlencoded({extended: false}))
app.use(cookieParser())
let pk = Buffer.from(process.env.PK, 'base64').toString('utf8')
app.use(expressJWT({
  secret: pk,
  getToken: function fromHeaderOrQuerystring (req) {
    if (req.headers.authorization && req.headers.authorization.split(' ')[0] === 'Bearer') {
      return req.headers.authorization.split(' ')[1]
    } else if (req.query && req.query.token) {
      return req.query.token
    }
    return null
  }
}))

let artifacts = require('./routes/artifacts')
app.use('/api/v1/artifacts', artifacts)
// catch 404 and forward to error handler
app.use(function (req, res, next) {
  let err = new Error('Not Found')
  err.status = 404
  next(err)
})

// error handler
app.use(function (err, req, res, next) {
  // set locals, only providing error in development
  res.locals.message = err.message
  res.locals.error = req.app.get('env') === 'development' ? err : {}
  // Logs.put(new Date().toISOString(), err.toString())
  // render the error page
  res.status(err.status || 500)
  let _response = {error: true, message: err.message}
  res.json(_response)
})

module.exports = app
