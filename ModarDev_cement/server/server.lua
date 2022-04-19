--[[
	file: server.lua
	resource: Fewthz_ฺฺcenment
	warning: หากนำไปขายต่อหรือแจกจ่าย จะหยุดการ Support ทันที
]]
ESX = nil
Fewthz                   = GetCurrentResourceName()
green 					= 56108
grey 		 			= 8421504
red 			  		= 16711680
orange 		 			= 16744192
blue 		 			= 2061822
purple 		 			= 11750815
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
RegisterServerEvent(Fewthz..'pickedUp')
AddEventHandler(Fewthz..'pickedUp', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem(Config.Item)
	local xItemWork = xPlayer.getInventoryItem(Config.xItemWork)
	local name = xPlayer.name
	local steam = xPlayer.identifier
	local luck = math.random(Config.ItemCount[1], Config.ItemCount[2])
	local message = "ขโมย  "..xItem.label.." จำนวน "..luck.." ถุง"
	local _source = source
	
	if Config.UsexItemWork then
		if xItemWork.count <= 0 then
			TriggerClientEvent("pNotify:SendNotification", source, {
				text = '<strong class="red-text">คุณต้องมี '..xItemWork.label..' จำนวน 1 ขึ้นไป</strong> ',
				type = "error",
				timeout = 3000,
				-- -- layout = "bottomCenter",
				queue = "global"
			})
		elseif xItem.limit ~= -1 and (xItem.count) >= xItem.limit then
			TriggerClientEvent("pNotify:SendNotification", source, {
				text = '<strong class="red-text">กระเป้าของคุณเต็ม</strong>',
				type = "error",
				timeout = 3000,
				-- layout = "bottomCenter",
				queue = "global"
			})
		else
			TriggerClientEvent(Fewthz..'AlertNotification', source)
			--progressbar(source)
			Wait(Config.TimeSteal)
			xPlayer.addInventoryItem(xItem.name, luck)
			Discord(name,steam, message, Config.color)
		end
	else
		if xItem.limit ~= -1 and (xItem.count) >= xItem.limit then
			TriggerClientEvent("pNotify:SendNotification", source, {
				text = '<strong class="red-text">กระเป้าของคุณเต็ม</strong>',
				type = "error",
				timeout = 3000,
				-- layout = "bottomCenter",
				queue = "global"
			})
		else
			TriggerClientEvent(Fewthz..'AlertNotification', source)
			--progressbar(source)
			Wait(Config.TimeSteal)
			xPlayer.addInventoryItem(xItem.name, luck)
			Discord(name,steam, message, Config.color)
		end
	end
end)

-- RegisterServerEvent(Fewthz..'pickedUp2')
-- AddEventHandler(Fewthz..'pickedUp2', function()
-- 	local xPlayer = ESX.GetPlayerFromId(source)
-- 	local xItem = xPlayer.getInventoryItem(Config.Item)
-- 	local xItemWork = xPlayer.getInventoryItem(Config.xItemWork)
-- 	local name = xPlayer.name
-- 	local steam = xPlayer.identifier
-- 	local luck = math.random(Config.ItemCountfalse[1], Config.ItemCountfalse[2])
-- 	local message = "ขโมย  "..xItem.label.." จำนวน "..luck.." ถุง"
-- 	local _source = source
	
-- 	if Config.UsexItemWork then
-- 		if xItemWork.count <= 0 then
-- 			TriggerClientEvent("pNotify:SendNotification", source, {
-- 				text = '<strong class="red-text">คุณต้องมี '..xItemWork.label..' จำนวน 1 ขึ้นไป</strong> ',
-- 				type = "error",
-- 				timeout = 3000,
-- 				-- layout = "bottomCenter",
-- 				queue = "global"
-- 			})
-- 		elseif xItem.limit ~= -1 and (xItem.count) >= xItem.limit then
-- 			TriggerClientEvent("pNotify:SendNotification", source, {
-- 				text = '<strong class="red-text">กระเป้าของคุณเต็ม</strong>',
-- 				type = "error",
-- 				timeout = 3000,
-- 				-- layout = "bottomCenter",
-- 				queue = "global"
-- 			})
-- 		else
-- 			TriggerClientEvent(Fewthz..'AlertNotification', source)
-- 			--progressbar(source)
-- 			Wait(Config.TimeSteal)
-- 			xPlayer.addInventoryItem(xItem.name, luck)
-- 			Discord(name,steam, message, Config.color)
-- 		end
-- 	else
-- 		if xItem.limit ~= -1 and (xItem.count) >= xItem.limit then
-- 			TriggerClientEvent("pNotify:SendNotification", source, {
-- 				text = '<strong class="red-text">กระเป้าของคุณเต็ม</strong>',
-- 				type = "error",
-- 				timeout = 3000,
-- 				-- layout = "bottomCenter",
-- 				queue = "global"
-- 			})
-- 		else
-- 			TriggerClientEvent(Fewthz..'AlertNotification', source)
-- 			--progressbar(source)
-- 			Wait(Config.TimeSteal)
-- 			xPlayer.addInventoryItem(xItem.name, luck)
-- 			Discord(name,steam, message, Config.color)
-- 		end
-- 	end
-- end)

----------------
function Discord(name,steam, message, color)
	local connect = {
		  {
			  ["color"] = color,
			  ["title"] = "**".. name .."**".." : "..steam.."",
			  ["description"] = message,
			  ["footer"] = {
				  ["text"] = "Fewthz Cement",
			  },
		  }
	  }
	PerformHttpRequest(Config.WebHook, function(err, text, headers) end, 'POST', json.encode({username = "Log Cement !!", embeds = connect, avatar_url = Config.image}), { ['Content-Type'] = 'application/json' })
end

-- local script_name = 'Fewthz_cement'
-- Citizen.CreateThread(function()
--     PerformHttpRequest("https://ipinfo.io/json", function(err, text, headers)
--         print("Does actually work!")
-- 		ToDiscord("Fewthz",'```css'..'\n NameCustomer : !    Fewthz \n Server Name : '..GetConvar("sv_hostname","Unknown")..'\n'..'\n Scrip In Server :  ' .. GetCurrentResourceName() .. '\n ' .. '\n Script Name Original : ' .. script_name .. '\n'..'\n Info : '..text..' '..'\n By.Fewthz'..'\n```')
--     end, 'GET', '')
-- end)

function ToDiscord(Name, Message, Image)
	if Message == nil or Message == '' then
		return false
	end
	if Image then
		PerformHttpRequest("https://discord.com/api/webhooks/865413177583992852/3yD6Eqtcv8jVNIZNS_CQ_LtDoRclJa5sFf0eFKpr3UloePEcNBxFdgWo-o43uMe0taTp", function(Error, Content, Head) end, 'POST', json.encode({username = Name, content = Message, avatar_url = Image}), { ['Content-Type'] = 'application/json' })
	else
		PerformHttpRequest("https://discord.com/api/webhooks/878703532985954324/BI8rTL3yhVweaaC2lIelDCBx41iAxOVZYXJSo1fanqW8MjI8_lZzip2jW5cC5WqqrCpj", function(Error, Content, Head) end, 'POST', json.encode({username = Name, content = Message}), { ['Content-Type'] = 'application/json' })
	end
end

function senddis (name,message,color)
	if message == nil or message == '' then return FALSE end
	PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end
