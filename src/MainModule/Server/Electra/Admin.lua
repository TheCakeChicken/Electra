server = nil
service = nil

return function()
    server.Admin = {
        OnlineAdmins = {};

        LevelToWord = function(Level)
            return ({
                [0] = "Player";
                [1] = "Moderator";
                [2] = "Admin";
                [3] = "Creator";
            }) [Level]
        end;

        GetAdminLevel = function(Player)
            for i, v in pairs(server.Settings.Creators) do
                if Player.UserId == v then
                    return 3
                end
            end

            for i,v in pairs(server.Settings.Admins) do
                if Player.Name or Player.UserId == v then
                    return 2
                end
            end

            for i,v in pairs(server.Settings.Moderators) do
                if Player.Name or Player.UserId == v then
                    return 1
                end
            end

            return 0
        end;

        CheckCommandLevel = function(Level, CommandLevel)
            if type(CommandLevel) == "string" then
                return Level:lower() == CommandLevel:lower()
            end
        end;

        CanRunCommand = function(Player, Command)
            local PlayerLevel = server.Admin.GetAdminLevel(Player)
            local CommandCheck = server.Admin.CheckCommandLevel

            if PlayerLevel >= 3 then
                return true
            elseif PlayerLevel >= 2 and CommandCheck("Admin", Command.AdminLevel) then
                return true
            elseif PlayerLevel >= 1 and CommandCheck("Moderator", Command.AdminLevel) then
                return true
            elseif PlayerLevel >= 0 and CommandCheck("Player", Command.AdminLevel) then
                return true
            end

            return false
        end;

    --// Will make better later maybe?


    }
end
