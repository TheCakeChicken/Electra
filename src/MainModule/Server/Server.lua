--[[
    Electra Server
]]

local original = {
    script = script;
    warn = warn;
    print = print;
    error = error;
}

local debugMode = true; --// Local variable because it needs to be accessed outside of function

local print = function(...) original.print("[Electra]", ...) end
local warn = function(...) original.warn("[Electra]", ...) end
local error = function(...) original.warn("[Electra | ERROR]", ...) end
local debugPrint = function(...) if debugMode then original.print("[Electra | DEBUG]", ...) end end
local debugWarn = function(...) if debugMode then original.warn("[Electra | DEBUG]", ...) end end

local server = {Root = script.Parent.Parent; DebugMode = false;}
local service = require(server.Root.Server.Electra.Service) --// the only file we will ever, ever manually require; it's functions are needed before the main modules are loaded.

return service.NewProxy("Electra_Core", {}, function(data)
    --// Should add another run check here to see if Electra's already running

    server.Deps = server.Root.Server.Dependencies;

    server.Deps.ClientLoader.Disabled = true

    if data and data.DebugMode then
        debugMode = true
        server.DebugMode = true
    end

    if data then
        server.Settings = data.Settings
    else
        server.Settings = require(server.Deps.DefaultSettings)
    end

    server.LoadOrder = {
        "Electra/Admin";
        "Electra/Processing";
        "Electra/Logs";
        "Electra/Remote";
        "Electra/Functions";
        "Electra/Commands";
        "Electra/AE";
        "Dependencies/Meta";
        "Dependencies/Credits";
        "Optional/TrelloAPI";
        (server.Settings.APIEnabled and "Optional/API" or nil);
        "Optional/DiscordAPI";
    }

    service.NewThread(function()
        for _,ModuleName in next,server.LoadOrder do
            local Split = service.Strings.Split(ModuleName, "/")
            local Folder = server.Root.Server:FindFirstChild(Split[1])
            if not Folder then return error('Failed to load module', ModuleName, 'Electra may not work. (Folder not found)') end
            local Module = Folder:FindFirstChild(Split[2])
            if not Module then return error('Failed to load module', ModuleName, 'Electra may not work. (Module not found)') end


            local func = require(Module)
            if typeof(func) == 'function' then
                local env = getfenv(func)
                env['print'] = function(...) print('('..tostring(Module)..')', ...) end
                env['warn'] = function(...) warn('('..tostring(Module)..')', ...) end
                env['error'] = function(...) error('('..tostring(Module)..')', ...) end
                env['debugPrint'] = function(...) debugPrint('('..tostring(Module)..')', ...) end
                env['debugWarn'] = function(...) debugWarn('('..tostring(Module)..')', ...) end
                env['server'] = server
                env['service'] = service

                setfenv(func, env)
                local a,b = pcall(func)
                if a and not b then debugWarn(tostring(Module), 'loaded successfully.') end
            else
                error('Failed to load module', tostring(Module), 'Electra may not work. (Did not return function)')
            end;
        end
    end)

    --// Get Electra's version
    if server.Settings.GetVersionNumberFromHTTP then
        server.Meta.GetMeta();
    end

    --// Setup remote
    server.Remote.Function = service.New('RemoteFunction')
    server.Remote.Function.Name = service.GenerateRandom(50)
    server.Remote.Function.Parent = service.JointsService
    server.Remote.Function.OnServerInvoke = server.Remote.Receive

    --// Fake remote to confuse exploiters
    server.AE.FakeRemotes()

    --// Setup internal events
    service.Events.Create('LoadClient')
    service.Events.Create('PlayerAdded')
    service.Events.Create('PlayerRemoving')
    service.Events.Create('CharacterAdded')
    service.Events.Hook('LoadClient', server.Processing.LoadClient)
    service.Events.Hook('PlayerAdded', server.Processing.PlayerAdded)
    service.Events.Hook('PlayerRemoving', server.Processing.PlayerRemoving)
    service.Events.Hook('CharacterAdded', server.Processing.CharacterAdded)

    --// Connect to Roblox Service events that we need
    service.Players.PlayerAdded:Connect(function(p) server.Functions.CheckBan(p) end) --// Checks if the user is banned and disconnects them
    service.Players.PlayerAdded:Connect(function(p) service.Events.Fire('LoadClient', p) end)
    service.Players.PlayerRemoving:Connect(function(p) service.Events.Fire('PlayerRemoving', p) end)

    service:NewLoop("Electra_ClientCheck", 15, server.Functions.CheckClients)

    --// If the module is loaded when a server is already running it loads the client to each player
    for i,v in next,service.Players:GetPlayers() do
        service.Events.Fire('LoadClient', v)
    end

    if data then
        server.Meta.LoadTime = math.ceil(tick() - data.Time)
        warn('Electra server version', server.Meta.Version, 'loaded. Loading took', tostring(server.Meta.LoadTime), 'ms.')
    else
        warn('Electra server version', server.Meta.Version, 'loaded. Electra loaded without data, forced to use default data!')
    end



    return "LOADED"
end)
