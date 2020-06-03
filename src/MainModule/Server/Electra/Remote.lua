server = nil
service = nil

return function()
    server.Remote = {
        Function = nil;
        Keys = {};

        Send = function(plr, ...)
            return server.Remote.Function:InvokeClient(plr, ...)
        end;

        Receive = function(plr, key, cmd, ...)
            if cmd ~= "ClientReady" and server.Remote.Keys[plr.UserId] ~= key then service.Disconnect(plr, "Attempted to call remote") return false end
            local func = server.Remote.Functions[cmd]
            if not func or typeof(func) ~= 'function' then return false end
            return func(plr, ...)
        end;

        Functions = {

            ClientReady = function(plr)
                if server.Remote.Keys[plr.UserId] then service.Disconnect(plr, "Attempted to change key") return end
                server.Remote.Keys[plr.UserId] = service.GenerateRandom(30)
                service.Events.Fire('PlayerAdded', plr)
                return server.Remote.Keys[plr.UserId]
            end;

            Echo = function(plr, ...)
                return(...)
            end; 

            Detected = function(plr, args)
				server.AE.Action.Detected(p, args[1], args[2])
			end;

        };
    }
end