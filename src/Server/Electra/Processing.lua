server = nil
service = nil

return function()
    server.Processing = {
        LoadClient = function(plr)
            --// This handles loading the client, and that is it.
            local loader = server.Deps.ClientLoader:Clone()
            local holder = service.New('ScreenGui')
            local folder = server.Root.Client:Clone()
            folder.Name = '#cake4president'
            folder.Parent = loader
            holder.ResetOnSpawn = false
            loader.Parent = holder
            holder.Parent = plr:WaitForChild('PlayerGui', 30)
            loader.Disabled = false
        end;

        PlayerAdded = function(plr) --// Gets called when the Electra client is loaded onto the player, NOT WHEN THEY JOIN THE GAME. (but it happens at the same time anyway)
            plr.CharacterAdded:Connect(function(char) service.Event.Fire('CharacterAdded', plr, char) end)
        end;

        CharacterAdded = function(plr, char)
        end;
    }
end