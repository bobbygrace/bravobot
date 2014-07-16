![Bravo, you!](https://dl.dropboxusercontent.com/u/379970/bravo.png)

Send bravos, little pictorial congratulations, via [slack.com](https://slack.com/).

To get up and running:

- `brew install phantomjs` (or [download](http://phantomjs.org/download.html))
- `npm install`
- `coffee app.coffee`

Set up a [new slash command in slack](https://trello.slack.com/services/new/slash-commands)
with the command “/bravo” and the URL you set up the 

Set up an [incoming webhook](https://trello.slack.com/services/new/incoming-webhook).
(Hint: the channel won’t matter.) Put your custom token in a file called “token”
in the app’s root path.

Enable the command in a channel, then do…

"/bravo @username for getting bravobot up and running!"

…then Bravo Bot come along will do its magic and return and custom image for
you. Bravo, you did it! :D
