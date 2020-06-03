server = nil
service = nil

return function()
    server.API = {
     --// Ideas: 
     --// API For checking a user is a admin
     --// API For checking a user is a banned
     --// API For getting trello data?
     --// API For the datastore (only if enabled in settings)
    }

    if server.Settings.API.Enabled then
        debugPrint('Set _G API')
        _G.Electra = server.API --// open up the _G API for Electra.
    end
    
end