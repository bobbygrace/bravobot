![Bravo, you!](https://dl.dropboxusercontent.com/u/379970/bravo.png)

Send bravos, little pictorial congratulations, via [slack.com](https://slack.com/).

To get the app up and running:

- `brew install phantomjs` (or [download](http://phantomjs.org/download.html))
- `npm install`
- `coffee app.coffee`

Get this li’l node app up set up on some accessible server (or use
[ngrok](https://ngrok.com/)).

In Slack, set up a [new slash command](https://trello.slack.com/services/new/slash-commands)
with the command “/bravo”. Add the URL, and use “Post” for the Method.

Then set up an [incoming webhook](https://trello.slack.com/services/new/incoming-webhook).
(Hint: the channel won’t matter.) Put your custom token in a file called
“token” in the app’s root path.

Then send a message in a channel, like…

“/bravo @username for getting bravobot up and running!”

…then Bravo Bot come along, mention the person, and post a custom image for
you. Bravo, you did it! :D
