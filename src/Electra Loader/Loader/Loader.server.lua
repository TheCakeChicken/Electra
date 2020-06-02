local module = game.ServerScriptService.MainModule
local settings = require(script.Parent.Parent.Config.Settings)
local data = {
	Loader = true;
	Debug = false;
	Settings = settings;
}

require(module)(data)
