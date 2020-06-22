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
            local torun = client.Remote.Functions[cmd]
            if not torun or typeof(torun) ~= 'function' then return false end
            return torun(...)
        end;

        Functions = {
            
            Echo = function(...)
                return client.Remote.Send("Echo", ...)
            end; 

            Print = function(...)
                print(...)
            end;

            Crash = function()
              return client.Functions.Crash()
            end;

			MakeGUI = function(Arguments)
              return client.UI.MakeGUI(Arguments, Arguments[1])
            end;

            ChatNotify = function(Message)
				pcall(function() 
					game:GetService("StarterGui"):SetCore("ChatMakeSystemMessage",{
                    Text = Message, 
					Color = Color3.new(255, 0 ,0)
					}) 
				end)
            end;
            
        };
    }
end