server = nil
service = nil

return function() --// Will add "action" things eventually so I can pass them over to better log things
    server.AE = {

        FakeRemotes = function()

        local FakeRemote = Instance.new("RemoteEvent")

        FakeRemote.Parent = game:GetService("ReplicatedStorage")
        
        FakeRemote.Name = "Electra_Data"
        
        local Detected = function(Player) --// Will setup a better exploit processing system later
            server.Discord.Log(Player,"Exploiting.")
            service.Disconnect(Player, "Exploiting.")
        end

        FakeRemote.OnServerEvent:Connect(Detected)

        end
        
    }
end