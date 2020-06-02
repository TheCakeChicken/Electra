server = nil
service = nil

return function()
    server.Datastore = {
        --// If trello dies, it'll use datastore to use the last bit of data it got so it still has bans
        --// Might also add some analytics stuff
    }
end