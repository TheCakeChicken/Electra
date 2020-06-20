local settings = {}

settings.Prefix = ";"

settings.Admins = {
    {				
        UserId = 100534123;
        Level = 1
    };
}

settings.DiscordLogging = false
settings.DiscordWebhookID = ""
settings.DiscordWebhookToken = "" 

settings.Trello = false
settings.TrelloAPIKey = ""
settings.TrelloAPIToken = ""

settings.Banned = {} --// UserIds or username, example: {"terryiscool160","100534123"}
settings.BanMessage = "You are banned from this game." --// What a user who is banned gets shown when they are kicked

--// You can get your ID and Token from where i've specified: https://discord.com/api/webhooks/id/token

return settings