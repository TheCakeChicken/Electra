local service; service = setmetatable({

  Datamodel = game;
  Heartbeat = game:GetService('RunService').Stepped;
  Loops = {};
  Instances = {};

  New = function(...)
    local obj = Instance.new(...)
    table.insert(service.Instances, obj)
    return obj
  end;
  
  NewProxy = function(name, func)
    assert(name and func, "")
    local proxy = newproxy(true)
    local meta = getmetatable(proxy)
    
    meta.__metatable = tostring(name) .. "_ElectraServer"
    meta.__call = function(tab, ...) return func(...) end
    meta.__index = function(t, i) return "Electra_Proxy" end

    return proxy
  end;

  NewLoop = function(self, name, time, func, ...)
    if not self.Loops[name] then
      self.Loops[name] = true
      spawn(function(...) 
        while self.Loops[name] do
          func(...)
          wait(time or 1)
        end
      end, ...)
    else
      error('Loop with name', name, 'already exists; It cannot be created.')
    end
  end;

  StopLoop = function(self, name)
    if not self.Loops[name] then
      error('Loop with name', name, 'does not exist; It cannot be stopped.')
    else
      self.Loops[name] = false
    end
  end;

  Strings = {
    Split = function(s, sep)
      local t = {}
      local sep = sep or " "
      local pattern = string.format("([^%s]+)", sep)
      string.gsub(s, pattern, function(c) t[#t + 1] = c end)
      return t
    end;
  };

},{

  __index = function(t, i)
    t[i] = t.Datamodel:GetService(i)
    return t[i]
  end;

  __metatable = "ElectraServer_Service";
  
})

return service