server = nil
service = nil

return function()
    server.AE = {

        Action = {

            function Detected = function(Player, Action, Info)
                if Player then
                  if Action:lower() == 'kick' then
                    service.Disconnect(Player, "Exploiting.")
                    if settings.DiscordLogging = true then
                      server.Discord.Log(Player, Action, Info)
                    end
                  end
                end

        }

        FakeRemotes = function()

        local FakeRemote = Instance.new("RemoteEvent")

        FakeRemote.Parent = game:GetService("ReplicatedStorage")
        
        FakeRemote.Name = "Electra_Data"
        
        local Detected = function(Player) 
           server.AE.Action.Detected(Player, "Kick", Info)
        end

        FakeRemote.OnServerEvent:Connect(Detected)

        end
        
    }
end