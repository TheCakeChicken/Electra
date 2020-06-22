client = nil
service = nil

return function()
    client.UI = {

        MakeGUI = function(Name, Data)
            local GUIModule = client.Root.UI:FindFirstChild(Name)
            if GUIModule then
                local GUI = GUIModule:Clone()
                local code = (GUI:IsA("ModuleScript") and GUI) or GUI:FindFirstChild("CodeModule")
                if code then
                    return service.LoadCustomModule(code, nil, Data)
                end
            end
        end

    }
end