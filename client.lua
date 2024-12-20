local blips = {}

function CreateZoneBlip(zone)
    Citizen.CreateThread(function()
        -- Sukuriamas blip'as
        local blip = Citizen.InvokeNative(0x45F13B7E0A15C880, zone.blipId, zone.x, zone.y, zone.z, zone.radius)
        table.insert(blips, blip)
    end)
end



-- Įtraukimas AddEventHandler, kad pašalintų blip'us, kai resursas sustabdytas
AddEventHandler("onResourceStop", function(resourceName)
    if GetCurrentResourceName() == resourceName then
        for _, blip in ipairs(blips) do
            RemoveBlip(blip) -- Remove each blip properly
        end
        blips = {}
    end
end)

-- Inicializavimas: Sukuriami blip'ai iš Config

Citizen.CreateThread(function()
    for _, zone in ipairs(Config.BlipZones) do
        CreateZoneBlip(zone)
    end
end)







