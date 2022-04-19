--[[
	file: config.lua
	resource: Fewthz_cement
	warning: หากนำไปขายต่อหรือแจกจ่าย จะหยุดการ Support ทันที
]]
local sec                   = 1000
Config						= {}
Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}
Config.Locale				= 'en'      -- Change the language. Currently only en  but will add fr soon.
Config.KeyControl           = "E"       -- Keyที่ใช้
Config.MiniGame             = true      -- MiniGame
Config.TimeSteal            = 15 * sec
Config.Cops                 = 0         -- จำนวนตำรวจที่สามารถขโมยใด้
Config.ItemCountfalse            = {0, 0}    -- ถ้าต้องการให้ได้ 1 ทุกครั้ง {1, 1} 2 ทุกครั้ง {2, 2} ถ้าให้สุ่ม {1, 2} ปรับแค่ตัวหลัง
Config.ItemCount                = {1, 1}    -- ถ้าต้องการให้ได้ 1 ทุกครั้ง {1, 1} 2 ทุกครั้ง {2, 2} ถ้าให้สุ่ม {1, 2} ปรับแค่ตัวหลัง
Config.Item                 = 'cement'  -- Item ที่ได้หลังจากขโมย
Config.UsexItemWork         = false		-- ต้องมี item อะไรถึงจะขโมยได้ true คือต้องมี false คือไม่ต้องใช่ไช้อะไรขโมยได้เลย
Config.xItemWork			= 'cementwork'		-- ต้องมี item นี้ถึงสามารถขโมยใด้
Config.UseFarfromCity		= true		-- กำหนดขอบเขตการขโมยปูน false ปิดขโมยได้ทุกที่ true กำหนดขอบเขต
Config.location				= -259.91464233398,-975.15985107422,31.220003128052
Config.FarfromCity 			= 1200  	-- ระยะห่างจากเมืองหลวง   JobCenter

----------------------------------------------------------------------------------------------------------------------------------------------------------------------
----- หลอดโหลด ------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------

function progressbarfalse()
	TriggerEvent("mythic_progbar:client:progress", {
        name = "Lockpicking",
        duration = Config.TimeSteal,
        label = "รอตำรวจมารับ",
        useWhileDead = false,
        canCancel = false,
        controlDisables = {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        },
        animation = {
            animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
            anim = "machinic_loop_mechandplayer",
            flags = 49,
        },
    })
end

function progressbar()
	TriggerEvent("mythic_progbar:client:progress", {
        name = "Lockpicking",
        duration = Config.TimeSteal,
        label = "กำลังตัดถุงปูน",
        useWhileDead = false,
        canCancel = false,
        controlDisables = {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        },
        animation = {
            animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
            anim = "machinic_loop_mechandplayer",
            flags = 49,
        },
    })
end

----------------------------------------------------------------------------------------------------------------------------------------------------------------------
----- Alt + 1 --------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------

Config.AlertKeyhook			= true						  -- ของค่ายอื่น ให้ใส่ trigger ใต้ function AlertKeyhook()
function AlertKeyhook()
	TriggerEvent("maxez-police:alertNet", "cement")
end
Config.AlertKeyhookBy       = "scotty-policealert"      -- เอาไว้ใส่ trigger เช่น "scotty-policealert:alertNet", "cement" ใส่แค่ "scotty-policealert"
Config.AlertCement          = "cement"                    -- คือตัวหลัง
Config.AlertNotification    = true                        -- แจ้งเตือนถ้าขโมยสำเร็จ
Config.AlertNotificationfalse = false                      -- แจ้งเตือนถ้าขโมยไม่สำเร็จ
Config.PhoneAlert			= true						  -- แจ้งเตือน โทรศัพท์ ถ้าขโมยสำเร็จ
Config.PhoneAlertfalse		= false 						  -- แจ้งเตือน โทรศัพท์ ถ้าขโมยไม่สำเร็จ

----------------------------------------------------------------------------------------------------------------------------------------------------------------------
----- Discord Log ----------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------

Config.WebHook 	= "https://discord.com/api/webhooks/882632120902778881/eGgzjPtIVXRYVO4OxGqlqlDcE9ClH-smL0cv9eC8N6jj2ItmzVEEL8TdfhxFkFCTIzz9"
Config.image	= "https://media.discordapp.net/attachments/717313713912414249/732597062691979364/images2.png"
Config.color	= red
-- สี
-- green
-- grey
-- red
-- orange
-- blue
-- purple

