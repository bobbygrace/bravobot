![Bravo, you!](https://dl.dropboxusercontent.com/u/379970/bravo.png)

Send bravos, little pictorial congratulations, in [slack.com](https://slack.com/).

In a channel, type…

> `/bravo @bobby for getting bravobot up and running!`

…then Bravo Bot will come along, mention the person, and post a custom image for
you.


## First, in Slack…

You need to do two things in Slack: set up a new slash command and set up an
incoming webhook. Open the Integrations tab, then…

- Add an **Incoming WebHook**. Copy the Webhook Url to your config file.
Give it a name, description, and an emoji (the clap emoji works best, imo.)
The channel won’t matter.

- Add a new **Slash Command** with the command “/bravo”. Add the URL from
which you will serve bravobot. Use “Post” for the method. Add “/bravo” as
the command. Copy the token to your config file.


## Add a config.json file

BravoBot will send your bravo picture to s3. Get a Key from AWS and
the other s3 information. Be sure to add a policy that makes your bucket
public.

Add a config.json file in the root of your project with all your secrets.
You config.json file will look something like this:

```
{
  "webhookUrl": "https://hooks.slack.com/services/123456/123456/123456",
  "token": "123456",
  "awsAccessKeyId": "123456",
  "awsSecretKey": "123456",
  "s3bucket": "bravobot",
  "s3region": "us-west-2"
}
```

Don't share your config file, obviously.


## Then, set up your server…

To get the app up and running:

- Add a config.json file like above. :point_up:
- `brew install phantomjs` (or [download](http://phantomjs.org/download.html))
- `npm install`
- `coffee app.coffee`

Have you heard of [ngrok](https://ngrok.com/)? It’s great.


## Just so you know…

You’ll want to add [Open Sans Condensed](https://www.google.com/fonts#UsePlace:use/Collection:Open+Sans+Condensed)
to your system. Webfonts don’t work with Phantom.js.

