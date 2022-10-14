local inZone = false
local currentZone = nil
local menuOpen = false

-- Initialisation
RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    ESX.PlayerData = xPlayer
    ESX.PlayerLoaded = true
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)
-- End of initialisation

-- Cloakrooms
function OpenCloakroomMenu()
    ESX.UI.Menu.CloseAll()
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'cloakroom_menu',{
        title = _U("cloakrooms_menu_name"),
        align = "top-left",
        elements = {
            {value = "job", label = _U("work_clothes")},
            {value = "offjob", label = _U("personal_clothes")},
        }
    }, function(data, menu)
        if data.current.value == "job" then
            ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
                if skin.sex == 0 then
                    TriggerEvent('skinchanger:loadClothes', skin, Config.Clothes.male)
                elseif skin.sex == 1 then
                    TriggerEvent('skinchanger:loadClothes', skin, Config.Clothes.female)
                end
            end)
        elseif data.current.value == "offjob" then
            ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                TriggerEvent('skinchanger:loadSkin', skin)
            end)
        end
    end, function(data, menu)
        menu.close()
    end)
end
-- End of Cloakrooms


-- Enter/Exit marker and keycontrols
Citizen.CreateThread(function()
    while true do
        local sleep = 1000
        local xPlayer = ESX.GetPlayerData(PlayerPedId())
        if xPlayer.job and xPlayer.job.name == Config.Job then
            local coords = GetEntityCoords(PlayerPedId())

            for _,v in pairs(Config.Zones) do
                local distance = #(coords - v.Pos)
                local x, y, z = table.unpack(v.Pos)

                if distance < Config.DrawDistance then
                    if v.Name == "boss" and xPlayer.job.grade_name == "boss" then
                        sleep = 5
                        DrawMarker(Config.MarkerType, x, y, z - 1, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
                        if distance <= Config.MarkerSize.x then
                            currentZone = v.Name
                            inZone = true
                        else
                            currentZone = nil
                            inZone = false
                        end
                    elseif v.Name ~= "boss" then
                        sleep = 5
                        DrawMarker(Config.MarkerType, x, y, z - 1, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
                        if distance <= Config.MarkerSize.x then
                            currentZone = v.Name
                            inZone = true
                        else
                            currentZone = nil
                            inZone = false
                        end
                    end
                end
            end

            for i=1, #Config.Stashes, 1 do
                if Config.Stashes[i].enabled then
                    local distance = #(coords - Config.Stashes[i].Pos)
                    local x, y, z = table.unpack(Config.Stashes[i].Pos)

                    if distance < Config.DrawDistance then
                        sleep = 5
                        DrawMarker(Config.MarkerType, x, y, z-1, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
                        if distance <= Config.MarkerSize.x then
                            ESX.ShowHelpNotification(_U("open_menu_help"))
                            if IsControlJustReleased(1, 38) then
                                if exports.ox_inventory:openInventory('stash', Config.Stashes[i].name) == false then
                                    TriggerServerEvent('ox:loadStashes')
                                    exports.ox_inventory:openInventory('stash', Config.Stashes[i].name)
                                end
                            end
                        end
                    end
                end
            end

            if inZone and currentZone ~= nil then
                ESX.ShowHelpNotification(_U("open_menu_help"))
                if IsControlJustReleased(1, 38) then
                    if currentZone == "patron" then
                        if xPlayer.job and xPlayer.job.name == Config.Job and xPlayer.job.grade_name == "boss" then
                            TriggerEvent('esx_society:openBossMenu', Config.Job, function(data, menu)
                                menu.close()
                            end, { wash = false })
                        end
                    elseif currentZone == "cloakroom" then -- here you can expand wich zone do what
                        OpenCloakroomMenu()
                    end
                    menuOpen = true
                end
            elseif not inZone then
                if menuOpen == true then
                    menuOpen = false
                    ESX.UI.Menu.CloseAll()
                end
            end
        end
        Citizen.Wait(sleep)
    end
end)
-- End of enter/Exit marker and keycontrols