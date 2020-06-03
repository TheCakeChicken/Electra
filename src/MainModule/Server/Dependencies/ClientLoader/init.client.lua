--[[
    Electra Client Loader

    "No, electricity will not make it load faster."
]]

local player = game:GetService('Players').LocalPlayer

local h = script:WaitForChild('Electra_Client', 60)
if not h then player:Kick('\nElectra - Disconnected:\nClient took too long') end

local module = h:FindFirstChild('Client')
if not module then player:Kick('\nElectra - Disconnected:\nClient took too long') end

require(module)(script, tick())
