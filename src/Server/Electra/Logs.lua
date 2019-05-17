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
            if not tab then return error('Log', type, 'does not exist.') end

            table.insert(tab, text)
        end
    }
end