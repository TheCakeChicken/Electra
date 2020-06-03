server = nil
service = nil

return function()
server.Processing = {
  ReadyPlayers = {};

  LoadClient = function(plr)
  local loader = server.Deps.ClientLoader:Clone()
  local holder = service.New('ScreenGui')
  local folder = server.Root.Client:Clone()
  folder.Name = '#cake4president'
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
  plr.CharacterAdded:Connect(
  function(char)
    service.Events.Fire("CharacterAdded", plr, char)
  end
  )
  repeat
    wait()
  until plr.Character
  service.Events.Fire("CharacterAdded", plr, plr.Character)
  plr.Chatted:Connect(
  function(Message, Recipient, plr)
    if not Recipient then
      server.Processing.Chat(plr, Message)
    end
  end
  )
  end;


  CharacterAdded = function(plr, char)
  end;

  PlayerRemoving = function(plr)
  server.Processing.ReadyPlayers[plr.UserId] = nil
  server.Remote.Keys[plr.UserId] = nil
  end;

  Chat = function(Player, Input)
    Message = string.lower(Input)
    
  end;

}
end