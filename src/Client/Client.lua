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

local client = {Root = original.script.Parent;}
local service = require(client.Root.Modules.Service) --// the only thing we require manually, it doesn't need the env and it's functions are needed much earlier on

return service.NewProxy("Electra_Client", {}, function(loaderScript, startTime)
    client.Root.Parent = nil --// get that the hecc out of here

    if not startTime then
        client.Player:Kick('Error while loading') --// something's tried to call it differently as the loader passes in startTime, that's suspicious.
    else
        client.LoadTime = math.ceil(tick() - startTime)
        warn('Electra Client loaded. Loading took', client.LoadTime, 'ms.')
    end
end)