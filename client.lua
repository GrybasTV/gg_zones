local blips = {}

function CreateZoneBlip(zone)
    Citizen.CreateThread(function()
        -- Sukuriamas blip'as
        local blip = Citizen.InvokeNative(0x45F13B7E0A15C880, zone.blipId, zone.x, zone.y, zone.z, zone.radius)
        table.insert(blips, blip)
    end)
end

-- Funkcija, pašalinanti visus sukurtus blip'us
function RemoveAllBlips()
    for _, blip in ipairs(blips) do
        Citizen.InvokeNative(0x45FF974EEE1C8734, blip)
    end
    blips = {}
end

-- Įtraukimas AddEventHandler, kad pašalintų blip'us, kai resursas sustabdytas
AddEventHandler("onResourceStop", function(resourceName)
    if GetCurrentResourceName() == resourceName then
        print("Removing all blips...")
        RemoveAllBlips()
    end
end)

-- Inicializavimas: Sukuriami blip'ai iš Config
Citizen.CreateThread(function()
    for _, zone in ipairs(Config.BlipZones) do
        CreateZoneBlip(zone)
    end
end)
