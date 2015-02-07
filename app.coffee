phantom = require 'phantom'
uuid = require 'node-uuid'
express = require 'express'
bodyParser = require 'body-parser'
fs = require 'fs'
http = require 'http'
request = require 'request'
app = express()

# You’ll want to change these, obviously.
webhookUrl = fs.readFileSync("webhookurl", {encoding: "utf8"})
token = fs.readFileSync("token", {encoding: "utf8"})
hostname = 'http://51e2e2e8.ngrok.com'

app.use '/bravos', express.static(__dirname + '/bravos')
app.use bodyParser.urlencoded()

generateBravo = (to, msg, from, callback) ->
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

          id = uuid.v4()
          filename = "bravos/#{id}.jpg"
          page.render filename, format: "jpg"
          ph.exit()
          callback(filename)

postToSlack = (channel, text, next) ->
  opts = {channel, text}
  opts.username = 'Bravo Bot'
  opts.parse = 'full'

  request.post webhookUrl, {form: {payload: JSON.stringify(opts) }}, (err, res, body) ->
    next(err)

app.post "/", (req, res) ->
  return if req.body.token.trim() != token.trim()

  text = req.body.text
  to = text.split(' ')[0]

  toPrefix = '@'

  if /^\#/.test(to)
    toPrefix = "#"

  to = to.replace /^(@|#)/, ''

  msg = text.split(' ')[1...].join(' ')
  channel = '#' + req.body.channel_name

  generateBravo "#{toPrefix}#{to}", msg, "@#{req.body.user_name}", (filename) ->
    path = [hostname, filename].join('/')
    postToSlack channel, "Bravo, #{toPrefix}#{to}! #{path}", ->
      res.send("")

app.listen(8080)
