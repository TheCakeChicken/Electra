server = nil
service = nil

return function()
    server.API = {
        AE = server.AE.Action;
    }

    _G.Electra = server.API --// open up the _G API for Electra.
end