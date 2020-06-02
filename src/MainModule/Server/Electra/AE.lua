server = nil
service = nil

return function()
    server.AE = {

        Action = {

            Detected = function(Player, Action, Info)
                if Player then
                  if Action:lower() == 'kick' then
                    service.Disconnect(Player, "Exploiting.")
                    warn("Player: "..Player.Name.." was removed for: "..Info)
                    if server.Settings.DiscordLogging then
                      server.Discord.Log(Player, Action, Info)
                    end
                  end
                end
              end;

        };

        FakeRemotes = function()

        local FakeRemote = Instance.new("RemoteEvent")

        FakeRemote.Parent = game:GetService("ReplicatedStorage")
        
        FakeRemote.Name = "Electra_Data"
        
        local Trip = function(Player) 
           server.AE.Action.Detected(Player, "Kick", "Firing a honeypot.")
        end

        FakeRemote.OnServerEvent:Connect(Trip)
       end
}
end