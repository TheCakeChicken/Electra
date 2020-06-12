server = nil
service = nil

return function()
    server.Admin = {

        local Levels = {
            ["-1"] = "Banned", 
            ["0"] = "Player", 
            ["1"] = "Moderator",
            ["2"] = "Admin", 
            ["3"] = "Creator",
        }

    }
end