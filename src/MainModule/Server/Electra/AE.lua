server = nil
service = nil

return function()
    server.AE = {

        FakeRemotes = function()

        local FakeRemote = Instance.new("RemoteEvent")

        FakeRemote.Parent = game:GetService("ReplicatedStorage")
        
        FakeRemote.Name = "Electra_Data"
        
        local Detected = function(Player)
            service.Disconnect(Player, "Exploiting.")
        end

        FakeRemote.OnServerEvent:Connect(Detected)

        end
        
    }
end