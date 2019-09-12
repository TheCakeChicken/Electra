server = nil
service = nil

return function()
    server.Logs = {
        Logs = {
            Chat = {};
            Exploit = {};
            Script = {};
            Command = {};
        };

        AddLog = function(self, type, text)
            assert(text and type, "server.Logs:AddLog must be called with a log type and text argument.")
            if typeof(self) == 'string' then return error('Function server.Logs.AddLog should be called with : and not .') end

            local tab = self.Logs[type]
            if not tab then return error('Log type', type, 'does not exist.') end

            table.insert(tab, text)
        end;

        ClearLog = function(self, type)
            assert(type, "server.Logs:ClearLog must be called with a log type argument.")
            if typeof(self) == 'string' then return error('Function server.Logs.ClearLog should be called with : and not .') end

            local tab = self.Logs[type]
            if not tab then return error('Log type', type, 'does not exist.') end

            self.Logs[type] = {}
        end;

        CreateLog = function(self, type)
            assert(type, "server.Logs:CreateLog must be called with a log type argument.")
            if typeof(self) == 'string' then return error('Function server.Logs.CreateLog should be called with : and not .') end

            local tab = self.Logs[type]
            if tab then return error('Log type', type, 'already exists.') end

            self.Logs[type] = {}
        end;
    }
end