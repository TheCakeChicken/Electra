--// You don't need to touch anything under here unless you're changing the module path

if _G["_Electra"] then
	warn("Electra already running!")
	script:Destroy()
 else
	 
 _G["_Electra"] = "Running"
 
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