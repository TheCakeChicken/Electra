
local server = {
    Root = script.Parent.Parent;
}
local service = require(server.Root.Server.Modules.Service)

return service.NewProxy("Electra_Core", function(data)

end)