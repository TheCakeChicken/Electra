server = nil
service = nil

return function()

    if server.Settings.DiscordLogging then
        debugPrint('Discord logging enabled.')

        debugPrint('Set Discord _G API')
        _G.Discord = server.Discord --// _G Var that will be used for discord logs if the user wants (so it can be used by the user outside of exploit logs for custom applications)

        server.Discord = {

            Log = function(Player, Action, Info) 
                if server.Settings.DiscordLogging = false or DiscordWebhookID = "" or DiscordWebhookToken = "" then 
                    warn("Discord log not enabled, or it's set to true and no token or ID is being provided.")
                end
                local info = {}
                info.embeds = {{}}
                info.embeds[1].title = 'Electra log'
                info.embeds[1].fields = {{name = 'Player',value = tostring(Player)},{name = 'Action',value = tostring(Action)},{name = 'Info',value = tostring(Info)}}
                server.Functions.PostEmbed(info)
            end;
            
        }

    else
        debugPrint('Discord logging disabled.')
    end

end