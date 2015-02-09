phantom = require 'phantom'
uuid = require 'node-uuid'
express = require 'express'
bodyParser = require 'body-parser'
fs = require 'fs'
http = require 'http'
request = require 'request'
s3 = require 's3'
app = express()

config = require './config'

webhookUrl = config.webhookUrl
token = config.token
awsAccessKeyId = config.awsAccessKeyId
awsSecretKey = config.awsSecretKey
s3bucket = config.s3bucket
s3region = config.s3region
s3Url = "https://s3-#{s3region}.amazonaws.com/#{s3bucket}"

app.use bodyParser.urlencoded()

client = s3.createClient({
  s3Options: {
    accessKeyId: awsAccessKeyId.trim()
    secretAccessKey: awsSecretKey.trim()
  }
})


generateBravo = (to, msg, from, next) ->
  phantom.create (ph) ->
    ph.createPage (page) ->
      pagePath = "#{__dirname}/public/bravo.html"
      page.open pagePath, (status) ->

        if (status != 'success')
          console.log 'Unable to access page.'
        else
          page.evaluate (to, msg, from) ->
            document.getElementsByClassName("js-to")[0].textContent = to
            document.getElementsByClassName("js-msg")[0].textContent = msg
            document.getElementsByClassName("js-from")[0].textContent = from
          , (->), to, msg, from

          setTimeout ->
            id = uuid.v4()
            filename = "bravos/#{id}.jpg"
            page.render filename, format: "jpg", ->
              next(filename)
              ph.exit()
          , 200

postBravoTos3 = (filename, next) ->

  params = {
    localFile: filename
    s3Params: {
      Bucket: s3bucket
      Key: filename
      ContentType: "image/jpeg"
    }
  }

  uploader = client.uploadFile(params)

  uploader.on 'error', (err) ->
    console.error "unable to upload: ", err.stack

  uploader.on 'end', (data) ->
    imgUrl = [s3Url, filename].join("/")
    next(imgUrl)

postToSlack = (channel, text, next) ->
  opts = {channel, text}
  opts.username = 'Bravo Bot'
  opts.parse = 'full'

  request.post webhookUrl, {form: {payload: JSON.stringify(opts) }}, (err, res, body) ->
    next(err)

app.post "/", (req, res) ->
  return if req.body.token != token

  text = req.body.text
  to = text.split(' ')[0]

  toPrefix = ', @'

  if /^\#/.test(to)
    toPrefix = ", #"

  to = to.replace /^(@|#)/, ''

  if to == ""
    toPrefix = ""
    to = "!"
    emptyTo = true

  msg = text.split(' ')[1...].join(' ')
  channel = '#' + req.body.channel_name

  generateBravo "#{toPrefix}#{to}", msg, "@#{req.body.user_name}", (filename) ->
    postBravoTos3 filename, (url) ->
      if emptyTo
        msg = "Bravo!"
      else
        msg = "Bravo#{toPrefix}#{to}!"

      postToSlack channel, "#{msg} #{url}", ->
        res.send("")

app.listen(10040)
