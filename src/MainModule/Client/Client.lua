--[[
    Electra Client
]]

local original = {
    script = script;
    warn = warn;
    print = print;
    error = error;
}

local debugMode = false; --// Local variable because it needs to be accessed outside of function

local print = function(...) original.print("[Electra]", ...) end
local warn = function(...) original.warn("[Electra]", ...) end
local error = function(...) original.warn("[Electra : ERROR]", ...) end
local debugPrint = function(...) if debugMode then original.print("[Electra : DEBUG]", ...) end end
local debugWarn = function(...) if debugMode then original.warn("[Electra : DEBUG]", ...) end end

local client = {Root = original.script.Parent; DebugMode = false;}
local service = require(client.Root.Electra.Service) --// the only thing we require manually, it doesn't need the env and it's functions are needed much earlier on

return service.NewProxy("Electra_Client", {}, function(loaderScript, startTime)
    client.Root.Parent = nil --// get that the hecc out of here

    local ERF = loaderScript:FindFirstChild('ERF')
    if not ERF then service.Player:Kick('\nElectra - Disconnected from server:\nFailure to obtain all required objects for Electra Client to load successfully.') end

    local DM = loaderScript:FindFirstChild('DM')
    if not DM then DM = service.New('BoolValue') DM.Value = false DM.Name = "DM" end
    client.DebugMode = DM.Value
    debugMode = DM.Value

    client.LoadOrder = {
        "Electra/Remote";
        "Electra/Functions";
        "Electra/UI";
        "Electra/AE";
    }

    service.NewThread(function()    
    for _,ModuleName in next,client.LoadOrder do
        local Split = service.Strings.Split(ModuleName, "/")
        local Folder = client.Root:FindFirstChild(Split[1])
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
            env['client'] = client
            env['service'] = service

            setfenv(func, env)
            local a,b = ypcall(func)
            if a and not b then debugWarn(tostring(Module), 'loaded successfully.') end
        else
            error('Failed to load module', tostring(Module), 'Electra may not work. (Did not return function)')
        end;
    end
    end)

    client.Remote.Function = ERF.Value

    ERF.Value = nil
    ERF:Destroy()
    DM:Destroy()

    client.Remote.Function.OnClientInvoke = client.Remote.Receive

    client.Remote.Key = client.Remote.Send('ClientReady')

    if not startTime then
        client.Player:Kick('Error while loading') --// something's tried to call it differently as the loader passes in startTime, that's suspicious.
    else
        client.LoadTime = math.ceil(tick() - startTime)
        warn('Electra Client loaded. Loading took', client.LoadTime, 'ms.')
    end
    
    pcall(function()
    game.StarterGui:SetCore("SendNotification", {
        Title = "Electra loaded!"; 
        Text = "Electra loaded successfully! (Dev only notification).";
        Icon = "";
        Duration = 5; 
    })
    end)
end)