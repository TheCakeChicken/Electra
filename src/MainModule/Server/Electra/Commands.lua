server = nil
service = nil

return function()
    server.Commands = {

        Test = {
            Prefix = ';';
            Commands = {'test'};
            Arguments = {'message'};
            Description = 'Test print command.';
            Disabled = false;
            AdminLevel = 'Admin';
            Function = function(plr, args)
                print("hi")
            end
        })
        
    }
end