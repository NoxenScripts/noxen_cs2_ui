client_script "@EasyCore/client/watchdog/external_modules.lua"
server_script "@EasyCore/server/watchdog/external_modules.lua"

server_script "@watchers/server/_rewriter.lua"
client_script "@STITGUARD/handler/stitguard.lua"
fx_version 'adamant'
games { 'gta5' }

server_exports {
    "AddEventForRessouurce",
    "CheckEventIntegrity",
}

client_scripts {
	'config/shared/**/*.lua',
    'config/client/**/*.lua',
    'client/**/*.lua',
}

server_scripts {
    'config/shared/**/*.lua',
    'config/server/**/*.lua',
    'server/**/*.lua',
}

lua54 "yes"