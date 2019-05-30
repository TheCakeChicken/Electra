server = nil
service = nil

return function()
    server.Processing = {
        ReadyPlayers = {};

        LoadClient = function(plr)
            local loader = server.Deps.ClientLoader:Clone()
            local holder = service.New('ScreenGui')
            local folder = server.Root.Client:Clone()
            folder.Name = '#cake4president'
            folder.Parent = loader
            holder.ResetOnSpawn = false
            loader.Parent = holder
            holder.Parent = plr:WaitForChild('PlayerGui', 30)
            loader:FindFirstChild('ERF').Value = server.Remote.Function
            loader:FindFirstChild('DM').Value = server.DebugMode
            loader.Disabled = false
            wait(60) --// 60 seconds for the client to load & return as ready

            if not server.Processing.ReadyPlayers[plr.UserId] then
                service.Disconnect(plr, "Client took too long\n[Failed to communicate to server]\nAttempt rejoining.")
            end
        end;

        PlayerAdded = function(plr)
            server.Processing.ReadyPlayers[plr.UserId] = true

            plr.CharacterAdded:Connect(function(char) service.Event.Fire('CharacterAdded', plr, char) end)
            repeat wait() until plr.Character
            service.Event.Fire('CharacterAdded', plr, plr.Character)

            server.Remote.Send('Print', "Test print from server")
        end;

        CharacterAdded = function(plr, char)
        end;
    }
end