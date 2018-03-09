'use strict'
const uuid = require('uuid')
const jwt = require('jsonwebtoken')
const nonce = require('nonce')()

/**
 * @name confirmEmailToken
 * @param id {String} id of the subject
 * @returns {Promise}
 */
const accessToken = function () {
  return new Promise(function (resolve, reject) {
    try {
      let jwtid = uuid.v4()
      let pk = Buffer.from(process.env.JWT_SIGNATURE, 'base64').toString('utf8')

      let jwtOpts = {
        jwtid: jwtid,
        algorithm: 'RS256'
      }

      return resolve(jwt.sign({fuck: 'off'}, pk, jwtOpts))
    } catch (e) {
      return reject(e)
    }
  })
}
const verifyAccessToken = function (token) {
  return new Promise(function (resolve, reject) {
    try {
      let pk = Buffer.from(process.env.PK, 'base64').toString('utf8')
      jwt.verify(token, pk, {algorithms: ['RS256']}, (tokenError, payLoad) => {
        if (tokenError) {
          return reject(tokenError)
        }
        return resolve(payLoad)
      })
    } catch (e) {
      return reject(e)
    }
  })
}
module.exports = {accessToken, verifyAccessToken}

