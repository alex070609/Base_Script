-- remove item from inventory
RegisterServerEvent(GetCurrentResourceName()..":removeItem")
AddEventHandler(GetCurrentResourceName()..":removeItem", function(item)
    local _source = source
    local _item = item
    exports.ox_inventory:RemoveItem(_source, _item, 1)
end)

-- add item to the inventory
RegisterServerEvent(GetCurrentResourceName()..":addItem")
AddEventHandler(GetCurrentResourceName()..":addItem", function(item)
    local _source = source
    local _item = item
    exports.ox_inventory:AddItem(_source, _item, 1)
end)