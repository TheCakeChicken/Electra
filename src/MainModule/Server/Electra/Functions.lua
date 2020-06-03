server = nil
service = nil

return function()
    server.Functions = {

        CheckClients = function()
            for i,v in next,service.Players:GetPlayers() do
                if server.Processing.ReadyPlayers[v.UserId] then
                    local time1 = tick()
                    local str = service.GenerateRandom(10)
                    local res = spawn(server.Remote.Send(v, "Echo", str))
                    local i = 0
                    repeat wait(1) i = i + 1 until res or i == 30
                    if i == 30 then
                        service.Disconnect(v, "Client check failed; Failure to return")
                    end
                    local time2 = tick()
                    if res ~= str then
                        service.Disconnect(v, "Client check failed; Incorrect return")
                    end;
                    if (time2-time1)/1000 > 15 then
                        service.Disconnect(v, "Client check failed; Took too long")
                    end;
                end
            end
        end;

        PostEmbed = function(data)
	        local WebhookLink = "https://discord.com/api/webhooks/"..server.Settings.DiscordWebhookID.."/"..server.Settings.DiscordWebhookToken
            local HttpService = game:GetService("HttpService")
            local encoded = HttpService:JSONEncode(data)
            HttpService:PostAsync(WebhookLink, encoded)
        end;

        FindUser = function(Input)
                if Input == "All" then
                      for i, v in pairs(game:GetService("Players"):GetChildren()) do
                            return v
                    end
                else
                    for i, v in pairs(game:GetService("Players"):GetChildren()) do
                        if v.UserId or v.Name == tonumber(Input) then
                            return v
                        end
                    end
                    
                    warn("Player: "..tostring(Input).." Not Found")
                end
            end;

            CheckBan = function(Player)
                if next(server.Settings.Banned) ~= nil then
                    for i, v in pairs(server.Settings.Banned) do
                        if Player.UserId or Player.Name == v then
                            service.Disconnect(Player, server.Settings.BanMessage)
                        end
                    end
                end
            end;

            FindCommand = function(CommandName)
                for i, v in pairs(server.Commands) do
                    for d, f in pairs(v.Commands) do
                        if f == CommandName then
                            return v
                        end
                    end
                end
                return nil
            end;
            

    }
end