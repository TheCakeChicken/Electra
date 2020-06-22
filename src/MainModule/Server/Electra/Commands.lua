server = nil
service = nil

return function()
    server.Commands = {

        Test = {
            Prefix = ';';
            Name = {"test"};
            Arguments = {};
            Description = "Test print command.";
            Disabled = false;
            AdminLevel = "Admin"; --// 0 = Player, 1 = Mod, 2 = Admin,
			Function = function(plr, args)
	
			server.Remote.Send(plr, "MakeGUI", "List", { Title = "Electra"; } );
				
            end
        };
        
    }
end