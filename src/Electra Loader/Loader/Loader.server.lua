--// You don't need to touch anything under here unless you're changing the module path

if _G["_Electra_Running"] == true then
	warn("Electra is already running on this server!")
	script:Destroy()
else
	
	local module = game.ServerScriptService.MainModule
	local settings = require(script.Parent.Parent.Config.Settings)
	local data = {
		Time = tick(); 
		Loader = true;
		Debug = true;
		Settings = settings;
	}
	require(module)(data)
end