-- Max number of adrenalines allowed
-- TODO: maybe make this a cvar instead
local max_adrenaline = 6

-- !! - Don't touch anything below - !!
-- Current version of the mod
local version = "1.0"

-- Number of max players on the server
local max_clients

-- When game is ready
function et_InitGame(levelTime, randomSeed, restart)
    -- Register mod and print in the server console that the mod has been loaded    
    et.RegisterModname("Adrenaline Limiter " .. version)
    et.G_Print("Adrenaline Limiter version " ..  version .. " loaded!\n")
    -- Get the max number of clients
    max_clients = tonumber(et.trap_Cvar_Get("sv_maxClients")) - 1
end

-- When a client spawns
function et_ClientSpawn(clientNum, revived, teamChange, restoreHealth) 
    -- Make use of the revived parameter so we don't actually give ammo back when a player is revived
    if (revived == 0) then
        -- Set the number of syringes
        -- NOTE: We have to use et.WP_MEDIC_SYRINGE because ammo is shared between syringes and adrenalines
        -- Using et.WP_MEDIC_ADRENALINE does not work
        et.gentity_set(clientNum, "ps.ammo", et.WP_MEDIC_SYRINGE, max_adrenaline - 1)
    end
end

-- On each game frame
function et_RunFrame(levelTime)
    -- Only execute below code every second, more often is not really useful, just makes things smoother
    if math.fmod(levelTime, 1000) ~= 0 then return end

    -- For each client slot on the server
    for i = 0, max_clients do
        -- If client has more syringes than allowed
        if et.gentity_get(i, "ps.ammo", et.WP_MEDIC_SYRINGE) >= max_adrenaline then
            -- Set the number of syringes to the max allowed amount
            et.gentity_set(i, "ps.ammo", et.WP_MEDIC_SYRINGE, max_adrenaline - 1)
        end
    end    
end