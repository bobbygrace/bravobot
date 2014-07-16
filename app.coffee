phantom = require 'phantom'
uuid = require 'node-uuid'
express = require 'express'
bodyParser = require 'body-parser'
fs = require 'fs'
http = require 'http'
request = require 'request'
app = express()

token = fs.readFileSync("token")
hostname = 'http://6468b236.ngrok.com'

app.use '/bravos', express.static(__dirname + '/bravos')
app.use bodyParser.urlencoded()

slack = (channel, text, next) ->
  opts = {channel, text}
  opts.icon_emoji = ':heart:'
  opts.username = 'Bravo Bot'
  opts.parse = 'full'

  request.post "https://trello.slack.com/services/hooks/incoming-webhook?token=#{token}", {form: {payload: JSON.stringify(opts) }}, (err, res, body) ->
    next(err)

app.post "/", (req, res) ->
  text = req.body.text
  to = text.split(' ')[0].replace /^@/, ''
  msg = text.split(' ')[1...].join(' ')
  channel = '#' + req.body.channel_name

  generateBravo to, msg, "@#{req.body.user_name}", (filename) ->
    path = [hostname, filename].join('/')
    slack channel, "Bravo, @#{to}! #{path}", ->
      res.send("")

app.listen(8080)

generateBravo = (to, msg, from, callback) ->
  phantom.create (ph) ->
    ph.createPage (page) ->
      page.open "#{__dirname}/public/bravo.html?to=#{to}&msg=#{msg}&from=#{from}", (status) ->
        id = uuid.v4()
        filename = "bravos/#{id}.png"
        page.render filename, format: "png"
        ph.exit()
        callback(filename)
