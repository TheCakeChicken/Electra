server = nil
service = nil

return function()

    if server.Settings.DiscordLogging.Enabled then
        debugPrint('Discord logging enabled.')

        debugPrint('Set Discord _G API')
        _G.Log = server.Discord --// _G Var that will be used for discord logs if the user wants (so it can be used by the user outside of exploit logs for custom applications)

        server.Discord = {
            
        }

    else
        debugPrint('Discord logging disabled.')
    end

end