server = nil
service = nil

return function()
    server.API = setmetatable({
        Name = 'Electra '..tostring(server.Meta.Version)..' interface API',
    },
    {
        __newindex = function()
            return 'This is locked'
        end;
        __tostring = function()
            return 'Electra '..tostring(server.Meta.Version)..' interface API'
        end;
        __metatable = function()
            return 'The Electra '..tostring(server.Meta.Version)..' interface API is locked, nice try'
        end;
    });

    if server.Settings.APIEnabled then
        debugPrint('Set _G API')
        _G.Electra = server.API --// open up the _G API for Electra.
    end
    
end