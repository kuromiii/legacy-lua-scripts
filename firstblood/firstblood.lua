-- Sound to play when first blood happens
-- You can use anything, but don't forget to put it in a pk3 file if you use a custom sound
-- TODO: maybe make this a cvar instead
local sound = "sound/misc/referee.wav"

-- The message to display when first blood happens
-- "%s" will get replaced by the player who drew the first blood
-- You can also use color codes
-- TODO: maybe make this a cvar instead
local message = "%s ^0HAS DRAWN THE FIRST BLOOD"

-- !! - Don't touch anything below - !!
-- Current version of the mod
local version = "1.0"

-- Whether or not first blood already happened
local firstBlood = false

-- "Special" entities which counts as suicide or map-based kills
local WORLDSPAWN_ENTITY = 1022
local ENTITYNUM_NONE = 1023

-- When game is ready
function et_InitGame(levelTime, randomSeed, restart)
    -- Register mod and print in the server console that the mod has been loaded
    et.RegisterModname("Firstblood " .. version)
    et.G_Print("First Blood Lua module version " ..  version .. " loaded!\n")
end

-- Utility function to get the team of the given client
function GetTeam(clientNum)
    return et.gentity_get(clientNum, "sess.sessionTeam")
end

-- When kill happens
function et_Obituary(target, attacker, meansOfDeath)
    -- If first blood didn't already happen
    if (not firstBlood) then
        -- Get current gamestate (warmup, intermission, playing, etc..)
        local gamestate = tonumber(et.trap_Cvar_Get("gamestate"))

        -- If attacker is a real player (aka attack is not the world or a null entity)
        -- AND attacker is different from target (aka not a self-kill)
        -- AND target team different from attacker team (aka not a team kill)
        -- AND the current state is GS_PLAYING (aka not intermission or warmup)
        -- TODO: do we just check that attacker is between 0 and 64 instead?
        if ((attacker ~= WORLDSPAWN_ENTITY and attacker ~= ENTITYNUM_NONE) and 
            (attacker ~= target) and (GetTeam(target) ~= GetTeam(attacker)) and 
            gamestate == et.GS_PLAYING) then

            -- Replace "%s" in our message with the player name
            local formatted_message = string.format(message, et.gentity_get(attacker, "pers.netname"))
            -- Show the formatted message to everyone
            et.trap_SendServerCommand(-1, "cp \"" .. formatted_message .. "\n\"")
            -- Play the sound to everyone
            et.G_globalSound(sound)

            -- First blood happened
            firstBlood = true
        end
    end
end