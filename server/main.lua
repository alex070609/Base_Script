ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


-- Here defines the registering of thes stashes defined in the config
AddEventHandler('onServerResourceStart', function(resourceName)
    if resourceName == 'ox_inventory' or resourceName == GetCurrentResourceName() then
        for _,v in pairs(Config.Stashes) do
            exports.ox_inventory:RegisterStash(v.name, v.label, v.slots, v.weight, v.specific, v.job, v.Pos)
        end
    end
end)