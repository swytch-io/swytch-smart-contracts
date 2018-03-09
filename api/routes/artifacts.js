const express = require('express')
let router = express.Router()
let fs = require('fs')
let path = require('path')

router.options('/', function (req, res, next) {
  res.status(200).json({data: ['GET']})
})

router.get('/:contractName', function (req, res, next) {
  let contractName = req.params.contractName
  try {
    let _path = path.join(process.env.PWD, 'build/contracts', contractName)
    let file = fs.createReadStream(_path)
    res.writeHead(200, {
      'Content-Type': 'application/json'
    })
    file.pipe(res)
    // return res.end()
  } catch (e) {
    return res.status(200).json({data: [], success: false, message: 'Not found'})
  }
  // res.status(200).json({data: ['GET']})
})

module.exports = router
