phantom = require 'phantom'
uuid = require 'node-uuid'
express = require 'express'
bodyParser = require 'body-parser'
http = require 'http'
app = express()

app.use(express.static(__dirname + '/public'))
app.use bodyParser.urlencoded()

app.get "/*", (req, res) ->
  res.sendfile(__dirname + '/public/bravo.html')

app.post "/", (req, res) ->
  text = req.body.text
  to = text.split(' ')[0]
  msg = text.split(' ')[1...].join(' ')

  generateBravo to, msg, "@#{req.body.user_name}", (filename) ->
    res.send("everything is fine")

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
