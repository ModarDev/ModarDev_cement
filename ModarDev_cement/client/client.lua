--[[
	file: client.lua
	resource: Fewthz_ฺฺcement
    warning: หากนำไปขายต่อหรือแจกจ่าย จะหยุดการ Support ทันที
]]
Fewthz                   = GetCurrentResourceName()
ESX						= nil
local PlayerData		= {}
local pedIsTryingToLockpickVehicle  = false
local showcopsmisbehave = true
local cachedBins        = {}
local InAction          = false
local Keys = {
    ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,["~"] = 243, 
    ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
    ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, 
    ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,["HOME"] = 213, 
    ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, 
    ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
    end
end)

RegisterNUICallback('Reviveok', function()
    SetNuiFocus(false, false)
    local player = GetPlayerPed(-1)
    ClearPedTasksImmediately (player)
    FreezeEntityPosition(player, true)
    progressbar()
	TriggerServerEvent(Fewthz..'pickedUp')
	FreezeEntityPosition(player, false)
    ClearPedTasks(GetPlayerPed(-1))
end)

RegisterNUICallback('Revivefalse', function()
    SetNuiFocus(false, false)
    local player = GetPlayerPed(-1)
    ClearPedTasksImmediately (player)
    FreezeEntityPosition(player, true)
	Wait(1000)
    FreezeEntityPosition(player, false)
    progressbarfalse()
    TriggerServerEvent(Fewthz..'pickedUp2')
    TriggerEvent("pNotify:SendNotification", {
		text = '<strong class="red-text">ขโมยไม่สำเร็จ</span>',
		type = "success",
		timeout = 5000,
		layout = "centerLeft",
		queue = "global"
    })
    if Config.AlertNotificationfalse then
        if Config.AlertKeyhook then
            AlertKeyhook()
        else
            TriggerEvent(Config.AlertKeyhookBy..":alertNet", Config.AlertCement)
        end
    end
    if Config.PhoneAlertfalse then
        SendDistressSignal()
    end
end)

RegisterNetEvent(Fewthz..'AlertNotification')
AddEventHandler(Fewthz..'AlertNotification', function()
    InAction          = true
    if Config.AlertNotification then
        if Config.AlertKeyhook then
            AlertKeyhook()
        else
            TriggerEvent(Config.AlertKeyhookBy..":alertNet", Config.AlertCement)
        end
    end
    if Config.PhoneAlert then
        SendDistressSignal()
    end
    
    Wait(Config.TimeSteal)

    InAction          = false
    Citizen.CreateThread(function()
        while InAction do
            Citizen.Wait(1)
            if InAction then
                local playerPed = PlayerPedId()
                DisableControlAction(0, 24, true) -- Attack
                DisableControlAction(0, 257, true) -- Attack 2
                DisableControlAction(0, 25, true) -- Aim
                DisableControlAction(0, 263, true) -- Melee Attack 1
                DisableControlAction(0, Keys["W"], true) -- W
                DisableControlAction(0, Keys["A"], true) -- A
                DisableControlAction(0, 31, true) -- S (fault in Keys table!)
                DisableControlAction(0, 30, true) -- D (fault in Keys table!)
                DisableControlAction(0, Keys["R"], true) -- Reload
                DisableControlAction(0, Keys["SPACE"], true) -- Jump
                DisableControlAction(0, Keys["Q"], true) -- Cover
                DisableControlAction(0, Keys["TAB"], true) -- Select Weapon
                DisableControlAction(0, Keys["F"], true) -- Also 'enter'?
                DisableControlAction(0, Keys["F1"], true) -- Disable phone
                DisableControlAction(0, Keys["F2"], true) -- Inventory
                DisableControlAction(0, Keys["F3"], true) -- Animations
                DisableControlAction(0, Keys["F6"], true) -- Job
                DisableControlAction(0, Keys["V"], true) -- Disable changing view
                DisableControlAction(0, Keys["C"], true) -- Disable looking behind
                DisableControlAction(2, Keys["P"], true) -- Disable pause screen
                DisableControlAction(0, 59, true) -- Disable steering in vehicle
                DisableControlAction(0, 71, true) -- Disable driving forward in vehicle
                DisableControlAction(0, 72, true) -- Disable reversing in vehicle
                DisableControlAction(2, Keys["LEFTCTRL"], true) -- Disable going stealth
                DisableControlAction(0, 47, true) -- Disable weapon
                DisableControlAction(0, 264, true) -- Disable melee
                DisableControlAction(0, 257, true) -- Disable melee
                DisableControlAction(0, 140, true) -- Disable melee
                DisableControlAction(0, 141, true) -- Disable melee
                DisableControlAction(0, 142, true) -- Disable melee
                DisableControlAction(0, 143, true) -- Disable melee
                DisableControlAction(0, 75, true) -- Disable exit vehicle
                DisableControlAction(27, 75, true) -- Disable exit vehicle
            end
        end
    end)
end)

function SendDistressSignal()
	local playerPed = PlayerPedId()
	PedPosition		= GetEntityCoords(playerPed)
	
    local PlayerCoords = { x = PedPosition.x, y = PedPosition.y, z = PedPosition.z }
    
    TriggerServerEvent('esx_addons_gcphone:startCall', 'police', ('มีคนกำลังขโมยปูน'), PlayerCoords, {

		PlayerCoords = { x = PedPosition.x, y = PedPosition.y, z = PedPosition.z },
	})
	
end

RegisterNetEvent(Fewthz..'MiniGame')   --- เมื่อ มีไอเทม
AddEventHandler(Fewthz..'MiniGame', function()
	SetNuiFocus(true,true)
	SendNUIMessage({ action = "cement",  })
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)

Citizen.CreateThread(function()
    Citizen.Wait(500)
    while true do
        Citizen.Wait(7)
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        local entity, entityDst = ESX.Game.GetClosestObject({
            "prop_cementbags01",
            "prop_cons_cements01"
        })
        local Coords = GetEntityCoords(entity)
        if Config.UseFarfromCity then
            if (GetDistanceBetweenCoords(coords, Config.location, false) < Config.FarfromCity) then
                if DoesEntityExist(entity) then
                    while GetDistanceBetweenCoords(playerCoords,Coords) <= 2 do
                        Coords = GetEntityCoords(entity)
                        playerCoords = GetEntityCoords(playerPed)
                        if IsPedOnFoot(playerPed) and not InAction and not cachedBins[entity] and entityDst then
                            local binCoords = GetEntityCoords(entity)

                            DrawText3Ds(binCoords.x, binCoords.y, binCoords.z + 1.5, "~g~[~r~ E ~g~]~w~ to Steal Cement.")
                            ESX.Game.Utils.DrawText3D(binCoords + vector3(0.0, 0.0, 0.5), "", 1.4)
                                    
                            if IsControlJustReleased(0, Keys[Config.KeyControl]) then
                                if not cachedBins[entity] then
                                    cachedBins[entity] = true
                                    if exports.Check:CheckPolice(Config.Cops) then
                                        OpenTrashCan()
                                        Wait(Config.TimeSteal)
                                    else
                                        TriggerEvent("pNotify:SendNotification", 
                                        {text = " ต้องการตำรวจจำนวน "..Config.Cops.." ในเมือง",
                                        type = "success", timeout = 5000,
                                        layout = "centerLeft"})
                                        Wait(5000)
                                    end
                                end
                            end
                        end
                        Citizen.Wait(0)
                    end
                end
                Citizen.Wait(1000)
            end
        else
            if DoesEntityExist(entity) then
                while GetDistanceBetweenCoords(playerCoords,Coords) <= 2 do
                    Coords = GetEntityCoords(entity)
                    playerCoords = GetEntityCoords(playerPed)
                    if IsPedOnFoot(playerPed) and not InAction and not cachedBins[entity] and entityDst then
                        local binCoords = GetEntityCoords(entity)

                        DrawText3Ds(binCoords.x, binCoords.y, binCoords.z + 1.5, "~g~[~r~ E ~g~]~w~ to Steal Cement.")
                        ESX.Game.Utils.DrawText3D(binCoords + vector3(0.0, 0.0, 0.5), "", 1.4)
                                
                        if IsControlJustReleased(0, Keys[Config.KeyControl]) then
                            if not cachedBins[entity] then
                                cachedBins[entity] = true
                                if exports.Check:CheckPolice(Config.Cops) then
                                    OpenTrashCan()
                                    Wait(Config.TimeSteal)
                                else
                                    TriggerEvent("pNotify:SendNotification", 
                                    {text = " ต้องการตำรวจจำนวน "..Config.Cops.." ในเมือง",
                                    type = "success", timeout = 5000,
                                    layout = "centerLeft"})
                                    Wait(5000)
                                end
                            end
                        end
                    end
                    Citizen.Wait(0)
                end
            end
            Citizen.Wait(1000)
        end
        
    end
end)


function DrawText3Ds(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())

    SetTextScale(0.5, 0.5)
    SetTextFont(6)
    SetTextProportional(1)
	SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 500
end

function OpenTrashCan()
    if Config.MiniGame then
        TriggerEvent(Fewthz..'MiniGame')
    else
        TriggerServerEvent(Fewthz..'pickedUp')
    end
end

