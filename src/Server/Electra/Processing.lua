server = nil
service = nil

return function()
    server.Processing = {
        LoadClient = function(p)
            --// This handles loading the client, and that is it.
            local loader = server.Deps.ClientLoader:Clone()
            local holder = service.New('ScreenGui')
            holder.ResetOnSpawn = false
            loader.Parent = holder
            holder.Parent = p:WaitForChild('PlayerGui', 30)
            loader.Disabled = false
        end;
    }
end