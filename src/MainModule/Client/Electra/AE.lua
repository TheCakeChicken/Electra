client = nil
service = nil
local detections = {"exploit","reziv admin"}

return function()
    client.AE = {

        --// Client log detection (will use remotes for communication later)

        spawn(function()
            while wait(5) do
                for i,v in pairs(game:GetService("LogService"):GetLogHistory()) do
                    for _,s in pairs(detections) do
                           local a,b = string.find(v.message, s)
                        if a then
                           client.Functions.Crash()
                        end
                    end
                end
            end
        end)

    }
end