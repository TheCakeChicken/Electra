
local server = {
    Root = script.Parent.Parent;
}
local service = require(server.Root.Server.Modules.Service) --// the only file we will ever, ever manually require; it's functions are needed before the main modules are loaded.

return service.NewProxy("Electra_Core", function(data)
    server.LoadOrder = {
            "Electra/Processing";
            "Electra/Events";
            "Electra/DataStore";
            "Electra/Core";
            "Electra/AE";
            "Electra/API";
            "Dependencies/Settings";
            "Dependencies/Meta";
            "Dependencies/Credits";
    }
        
    for _,ModuleName in next,server.LoadOrder do
            local Split = service.Strings.Split(ModuleName)
    end
end)
