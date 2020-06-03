server = nil
service = nil

return function()
    local Datastore = service.DataStoreService:GetDataStore('Electra_Datastore' .. tostring((service.Datamodel.PlaceId + 213213312) * 412321312));       
    
    server.Datastore = {

        --// If trello dies, it'll use datastore to use the last bit of data it got so it still has bans
        --// Might also add some analytics stuff later


        Get = function(Item)
            return Datastore:GetAsync("Datastore_" .. Item)
        end;
        
        Set = function(Item, Value)
            return Datastore:SetAsync("Datastore_" .. Item, Value)
        end;

        Update = function(Item, Value)
            return Datastore:UpdateAsync("Datastore_" .. Item, Value)
        end;
        
        Remove = function(Item)
            Datastore:RemoveAsync(tostring(Item))
            warn('DataStore: "' .. tostring(Item) .. '" was removed')
        end

    }
end