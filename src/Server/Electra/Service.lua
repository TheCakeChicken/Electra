local service; service = setmetatable({

  Datamodel = game;
  Heartbeat = game:GetService('RunService').Stepped;
  Loops = {};
  Instances = {};
  EventStorage = {};

  New = function(...)
    local obj = Instance.new(...)
    table.insert(service.Instances, obj)
    return obj
  end;
  
  NewProxy = function(name, tab, func)
    assert(name, "service.NewProxy must be called with a name argument")
    local proxy = newproxy(true)
    local meta = getmetatable(proxy)
    
    meta.__metatable = tostring(name) .. "_ElectraServer"
    if func ~= nil then meta.__call = function(tab, ...) return func(...) end end
    meta.__index = function(t, i) return "Electra_Proxy" end

    for i,v in next,tab do
      meta[i] = v;
    end

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

  Events = {
    Create = function(name)
      assert(name, "service.Events.Create must be called with a name")
      service.EventStorage[name] = {
        Event = service.New('BindableEvent');
        HookedFunctions = {};
      }

      service.EventStorage[name].Event.Event:Connect(function(...)
        for _,func in next,service.EventStorage[name].HookedFunctions do
          func(...)
        end
      end)

      return service.EventStorage[name].Event
    end;

    Get = function(name)
      assert(name, "service.Events.Get must be called with a name")
      if service.EventStorage[name] and service.EventStorage[name].Event then return service.EventStorage[name].Event end
      service.EventStorage[name] = {
        Event = service.New('BindableEvent');
        HookedFunctions = {};
      }

      service.EventStorage[name].Event.Event:Connect(function(...)
        for _,func in next,service.EventStorage[name].HookedFunctions do
          func(...)
        end
      end)

      return service.EventStorage[name].Event
    end;

    Hook = function(name, func)
      assert(name, "service.Events.Hook must be called with a name")
      if not service.EventStorage[name] then return error('Event with name', name, 'not found. Cannot hook.') end

      table.insert(service.EventStorage[name].HookedFunctions, func)
    end;

    Fire = function(name, ...)
      assert(name, "service.Events.Fire must be called with a name")
      if not service.EventStorage[name] then return error('Event with name', name, 'not found. Cannot fire.') end

      service.EventStorage[name].Event:Fire(...)
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