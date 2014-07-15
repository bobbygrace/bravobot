express = require('express')
app = express()

app.use(express.static(__dirname + '/public'))

app.get "/*", (req, res) ->
  res.sendfile(__dirname + '/public/bravo.html')

app.listen(8080)
