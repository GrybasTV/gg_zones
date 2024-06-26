Config = Config or {}

local blips = {}

function CreateZoneBlip(zone)
    Citizen.CreateThread(function()
        -- Sukuriamas blip'as
        local blip = Citizen.InvokeNative(0x45F13B7E0A15C880, zone.blipId, zone.x, zone.y, zone.z, zone.radius)      
    end)
end


