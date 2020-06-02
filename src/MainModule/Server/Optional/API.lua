server = nil
service = nil

return function()
    server.API = {

    }
    if server.Settings.API.Enabled then
        debugPrint('Set _G API')
        _G.Electra = server.API --// open up the _G API for Electra.
    end
end