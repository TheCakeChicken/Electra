server = nil
service = nil

return function()
    server.Admin = {

        GetAdminLevel = function(Player)
                for i,v in next (server.Settings.Admins) do
                    if Player.Name == v.Name or Player.UserId == v.UserId then
                        return v.Level
                    end
                return 0 --// 0 = Player level
            end
        end;

        --// Will add level number to creator etc later


    }
end