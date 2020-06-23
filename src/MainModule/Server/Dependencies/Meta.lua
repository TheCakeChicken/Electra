server = nil
service = nil

return function()
    server.Meta = {

            GetMeta = function()
                local HttpService = game:GetService("HttpService")
                local GIT_URL = "https://api.github.com/repos/TheCakeChicken/Electra/commits/master"
                local Get
                local Data

                local GetVersion = function()
                    Get = HttpService:GetAsync(GIT_URL)
                    Data = HttpService:JSONDecode(Get)
                end

                xpcall(GetVersion, function(Err)
                    print("Error getting version from github: " .. Err)
                end);

                local Version = "git-"..(Data.sha):sub(1,7) --or "Unknown"

                server.Meta.Version = Version
                return Version

            end;

            Branch = "Master";
            Version = "Unknown";
            LoadTime = nil;
    }
end
