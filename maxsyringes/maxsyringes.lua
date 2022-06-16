-- Max number of syringes allowed
-- TODO: maybe make this a cvar instead
local max_adrenaline = 6

-- !! - Don't touch anything below - !!
-- Current version of the mod
local version = "1.0"

-- Number of max players on the server
local maxclients

-- When game is ready
function et_InitGame(levelTime, randomSeed, restart)
    -- Register mod and print in the server console that the mod has been loaded    
    et.RegisterModname("Adrenaline Limiter " .. version)
    et.G_Print("Adrenaline Limiter version " ..  version .. " loaded!\n")
    -- Get the max number of players
    maxclients = tonumber(et.trap_Cvar_Get("sv_maxClients")) - 1
end

-- When client spawns
function et_ClientSpawn(clientNum, revived, teamChange, restoreHealth)
    -- Set the number of syringes on spawn
    if (revived == 0) then
        -- make use of the revived parameter so we don't actually give ammo back on revive
        et.gentity_set(clientNum, "ps.ammo", et.WP_MEDIC_SYRINGE, max_adrenaline - 1)
    end
end

-- On each game frame
function et_RunFrame(levelTime)
    -- Only execute below code every second
    if math.fmod(levelTime, 1000) ~= 0 then return end

    -- For each client 
    for i = 0, maxclients do
        -- If they have more ammo than allowed
        if et.gentity_get(i, "ps.ammo", et.WP_MEDIC_SYRINGE) >= max_adrenaline then
            -- Set the number of syringes to the max allowed amount
            et.gentity_set(i, "ps.ammo", et.WP_MEDIC_SYRINGE, max_adrenaline - 1)
        end
    end    
end