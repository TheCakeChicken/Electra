server = nil
service = nil

return function()
    if server.Settings.Trello then
        debugPrint('Trello Module is enabled.')
        server.TrelloAPI = { 

        }
    else
        debugPrint('Trello Module is disabled.')
    end
end