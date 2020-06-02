server = nil
service = nil

return function()
    server.Changelog = {
        "Version: " ..server.Meta.Version
    }
end