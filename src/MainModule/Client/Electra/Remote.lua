client = nil
service = nil

return function()
    client.Remote = {
        Function = nil;
        Key = "AWAITING";

        Send = function(...)
            return client.Remote.Function:InvokeServer(client.Remote.Key, ...)
        end;

        Receive = function(cmd, ...)
            local func = client.Remote.Functions[cmd]
            if not func or typeof(func) ~= 'function' then return false end
            return func(...)
        end;

        Functions = {
            Echo = function(arg)
                return arg
            end;

            Print = function(...)
                print(...)
            end;

            ChatNotify = function(Message)
				Pcall(function() 
					game:GetService("StarterGui"):SetCore("ChatMakeSystemMessage",{
                    Text = Message, 
					Color = Color3.new(255, 0 ,0)
					}) 
				end)
			end;
        };
    }
end