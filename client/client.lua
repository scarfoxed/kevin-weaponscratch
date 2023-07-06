local QBCore = exports['qb-core']:GetCoreObject()

local ScratchTable = nil

AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
        DeleteEntity(ScratchTable)
    end
end)

local function ShowWeapons()
    local inv = exports.ox_inventory:GetPlayerItems(source)
    if IsPedArmed(cache.ped, 7) then
        TriggerEvent('weapons:ResetHolster')
        SetCurrentPedWeapon(cache.ped, `WEAPON_UNARMED`, true)
    end

    local resgisteredMenu = {
        id = 'kevin-weaponscratch',
        title = 'Available Weapons',
        options = {}
    }
    local options = {}
    for _, item in pairs(inv) do
        if string.find(item.name, "WEAPON_")and item.metadata.serial ~= 'Scratched' then
            options[#options+1] = {
                title = item.label,
                description = 'Scratch Weapon Serial',
                metadata = {
                    {label = 'Serial', value = item.metadata.serial},
                    {label = 'Slot', value = item.slot},
                },
                serverEvent = 'kevin-weaponscratch:scratchserial',
                args = {
                    weapon = item.name,
                    slot = item.slot
                }
            }
        end
    end

    resgisteredMenu["options"] = options
    lib.registerContext(resgisteredMenu)
    lib.showContext('kevin-weaponscratch')
end

CreateThread(function ()
    local coords = vector4(726.12, -1074.31, 28.31, 183.06)
    local hash = `prop_toolchest_05`
    lib.requestmodel(hash)
    ScratchTable = CreateObject(hash, coords.x, coords.y, coords.z -1, true, true, true)
    SetEntityHeading(ScratchTable, coords.w)
    FreezeEntityPosition(ScratchTable, true)
    exports['ox_target']:addBoxZone({
        coords = coords,
        size = vector3(1.7, 0.8, 1.7),
        debug = false,
        options = {
            {
                name = 'table1',
                icon = 'fas fa-screwdriver',
                label = 'Use Tools',
                onSelect = function()
                    ShowWeapons()
                end,
            },
        },
        distance = 2.0
    })
end)
