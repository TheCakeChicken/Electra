server = nil
service = nil

return function()
  server.Processing = {
    ReadyPlayers = {};

    LoadClient = function(plr)
      local loader = server.Deps.ClientLoader:Clone()
      local holder = service.New('ScreenGui')
      local folder = server.Root.Client:Clone()
      folder.Name = 'Electra_Client'
      folder.Parent = loader
      holder.ResetOnSpawn = false
      loader.Parent = holder
      holder.Parent = plr:WaitForChild('PlayerGui', 30)
      loader:FindFirstChild('ERF').Value = server.Remote.Function
      loader:FindFirstChild('DM').Value = server.DebugMode
      loader.Disabled = false
      wait(60) --// 60 seconds for the client to load & return as ready

      if not server.Processing.ReadyPlayers[plr.UserId] then
        service.Disconnect(plr, "Client took too long\n[Failed to communicate to server]\nAttempt rejoining.")
      end

    end;

    PlayerAdded = function(plr)
      server.Processing.ReadyPlayers[plr.UserId] = true
      warn("Loading player", tostring(plr))

      plr.CharacterAdded:Connect(function(char)
        service.Events.Fire("CharacterAdded", plr, char)
      end);
      repeat wait() until plr.Character
      service.Events.Fire("CharacterAdded", plr, plr.Character)
      
      plr.Chatted:Connect(function(Message, Recipient, plr)
        if not Recipient then
          server.Processing.Chat(plr, Message)
        end
      end)
    end;


    CharacterAdded = function(plr, char)

    end;

    PlayerRemoving = function(plr)
      server.Processing.ReadyPlayers[plr.UserId] = nil
      server.Remote.Keys[plr.UserId] = nil
    end;

    Chat = function(Player, Input)

      if Input:match(server.Settings.Prefix) then
        server.Processing.ProcessChat(Player, Input)
      end

    end;

    ProcessChat = function(Player, Message)

      local Message = string.lower(Message)

      if Message:sub(1, 2) == "/e" then
        Message = Message:sub(4)
      end

      local Arguments = {};
      local Text = {};
      local ToRun

      for found in string.gmatch(Message, "%w+") do
        table.insert(Text, found)
      end

      ToRun = Text[1]

      for index = 2, #Text do
        table.insert(Arguments, Text[index])
      end

      if ToRun then
        local Command = server.Functions.FindCommand(ToRun)
        if Command and #Arguments >= #Command.Arguments then
          server.Processing.RunCommand(Player, Command, Arguments)
        else
          --//Add event callback to client
        end;
      end

    end;

    RunCommand = function(Player, Command, Arguments)

      local RanCommand = function()
        Command.Function(Player, Arguments)
      end;

      xpcall(RanCommand, function(Err)
        print("Error running the command: " .. Err)
      end);
      
    end};
    
end