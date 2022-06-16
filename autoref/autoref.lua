-- List of allowed users
-- You may add more users or remove them as you wish
-- Keep in mind you need to add a comma at the end of each line, and a closing bracket at the end of the list
local allowed_guids = {"insert guid here", 
             "insert guid here",
             "insert guid here",
             "insert another guid here 2",
             "insert yet another guid here"}

-- !! - Don't touch anything below - !!
-- Current version of the mod
local version = "1.0"

-- When game is ready
function et_InitGame(levelTime, randomSeed, restart)
    -- Register mod and print in the server console that the mod has been loaded
    et.RegisterModname("Autoref " .. version)
    et.G_Print("Autoref module version " ..  version .. " loaded! There are currently ".. #allowed_guids.. " allowed users.\n")
end

-- When client has entered the game
function et_ClientBegin(clientNum, firstTime, isBot)
    -- Get user GUID from client userinfo, and put it in uppercase (used for easier comparing)
    local userinfo = et.trap_GetUserinfo(clientNum) 
    local guid = string.upper(et.Info_ValueForKey(userinfo, "cl_guid"))

    -- For each allowed GUID in the list
    for index = 1, #allowed_guids do
        -- If GUID (also in uppercase) matches the one of the client
        if guid == string.upper(allowed_guids[index]) then
            -- Set client as referee, let them know with a message, and notify that the userinfo changed
            et.gentity_set(clientNum, "sess.referee", 1)
            et.trap_SendServerCommand(clientNum, "cpm \"You have automatically been added as referee\n\"")
            et.ClientUserinfoChanged(clientNum)
        end
    end
end