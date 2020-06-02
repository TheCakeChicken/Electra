server = nil
service = nil

return function()

    if server.Settings.DiscordLogging then
        debugPrint('Discord logging enabled.')

        debugPrint('Set Discord _G API')
        _G.Discord = server.Discord --// _G Var that will be used for discord logs if the user wants (so it can be used by the user outside of exploit logs for custom applications)

        server.Discord = {

            Log = function(Player, Info) 
                local info = {}
                info.embeds = {{}}
                info.embeds[1].title = 'Electra log'
                info.embeds[1].fields = {{name = 'Player',value = tostring(Player)},{name = 'Info',value = tostring(Info)}}
                server.Functions.PostEmbed(info)
            end;
            
        }

    else
        debugPrint('Discord logging disabled.')
    end

end