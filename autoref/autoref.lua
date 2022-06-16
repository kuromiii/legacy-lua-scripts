local version = "1.0"

-- List of allowed users
-- You may add more users or remove them as you wish
-- Keep in mind you need to add a comma at the end of each line, and a closing bracket at the end of the list
local allowed_guids = {"insert guid here", 
             "insert guid here",
             "insert guid here",
             "insert another guid here 2",
             "insert yet another guid here"}

-- Register mod and print in the server console that the mod has been loaded
function et_InitGame(levelTime, randomSeed, restart)
    et.RegisterModname("Autoref " .. version)
    et.G_Print("Autoref module version " ..  version .. " loaded! There are currently ".. #allowed_guids.. " allowed users.\n")
end

function et_ClientBegin(clientNum, firstTime, isBot)
    -- Get user GUID from userinfo, and put it in uppercase
    local userinfo = et.trap_GetUserinfo(clientNum) 
    local guid = string.upper(et.Info_ValueForKey(userinfo, "cl_guid"))

    -- For each allowed GUIDs
    for index = 1, #allowed_guids do
        -- If GUID matches
        if guid == allowed_guids[index] then
            -- Set user as referee, let them know, and notify that the userinfo changed
            et.gentity_set(clientNum, "sess.referee", 1)
            et.trap_SendServerCommand(clientNum, "cpm \"You have automatically been added as referee\n\"")
            et.ClientUserinfoChanged(clientNum)
        end
    end
end