-- Užtikriname, kad Config yra inicializuotas
Config = Config or {}

local blips = {}

function CreateZoneBlip(zone)
    Citizen.CreateThread(function()
        -- Sukuriamas blip'as
        local blip = Citizen.InvokeNative(0x45F13B7E0A15C880, zone.blipId, zone.x, zone.y, zone.z, zone.radius)
        table.insert(blips, blip) -- Pridedame blip'ą į registrą

        -- Palaukite 45 sekundes
        Citizen.Wait(45000)

        -- Pašalina blip'ą
        Citizen.InvokeNative(0x45FF974EEE1C8734, blip)
    end)
end

-- debug: Tikriname, ar Config teisingai įkrautas
Citizen.CreateThread(function()
    if not Config or not Config.BlipZones then
        print("Config arba Config.BlipZones yra nil")
        return
    end

    for i, zone in ipairs(Config.BlipZones) do
        print("Sukuriamas blip'as zonoje:", i, zone.x, zone.y, zone.z)
        CreateZoneBlip(zone)
    end
end)

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
        RemoveAllBlips()
    end
end)
