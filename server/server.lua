RegisterNetEvent('kevin-weaponscratch:scratchserial', function(data)
    local src = source
    local ox_inventory = exports.ox_inventory
    local weapon = ox_inventory:GetSlot(src, data.slot)
    local hasItem = ox_inventory:Search(src, 'count', 'steelfile')
    if hasItem > 0 then
            weapon.metadata.serial = 'Scratched'
            ox_inventory:SetMetadata(src, data.slot, weapon.metadata)
            --TriggerClientEvent("QBCore:Notify", src, 'Serial Successfully Scratched', "success")
            lib.notify(source, { description = "Serial Successfully Scratched", type = 'success', })
    else
        --TriggerClientEvent("QBCore:Notify", src, 'You do not have any tools for this..', "error")
            lib.notify(source, { description = "You do not have any tools for this", type = 'error', })
    end
end)
