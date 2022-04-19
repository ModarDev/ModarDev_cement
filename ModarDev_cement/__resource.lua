--[[
	resource: Fewthz_cement
  	warning: หากนำไปขายต่อหรือแจกจ่าย จะหยุดการ Support ทันที
]]
resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

version '1.0.1'

ui_page 'html/ui.html'

client_scripts {
	'@es_extended/locale.lua',
	'client/client.lua',
	'config.lua'
}

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'server/server.lua',
	'config.lua'
}

files {
    'html/ui.html',
    'html/css/main.css',
    'html/js/app.js',
}

dependency {
	'es_extended',
	'pNotify',
	'Check'
}
