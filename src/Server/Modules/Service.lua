return setmetatable({

  Datamodel = game;
  Heartbeat = game:GetService('RunService').Stepped;
  
},{

  __index = function(t, i)
    t[i] = t.Datamodel:GetService(i)
    return t[i]
  end;
  
})
