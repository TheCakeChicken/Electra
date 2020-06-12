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
            AdminLevel = "Admin";
            Function = function(plr, args)
                print("wow it works")
            end
        };
        
    }
end