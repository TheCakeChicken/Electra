server = nil
service = nil

return function()
    server.Commands = {

        Test = {
            Prefix = ';';
            Name = {"test", "testing"};
            Arguments = {"player", "message"};
            Description = "Test print command.";
            Disabled = false;
            AdminLevel = "Admin"; --// 0 = Player, 1 = Mod, 2 = Admin,
            Function = function(plr, args)
                print("wow it works")
            end
        };
        
    }
end