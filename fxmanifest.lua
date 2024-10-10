client_script "@EasyCore/client/watchdog/external_modules.lua"
server_script "@EasyCore/server/watchdog/external_modules.lua"

server_script "@watchers/server/_rewriter.lua"
client_script "@STITGUARD/handler/stitguard.lua"
fx_version 'adamant'
games { 'gta5' }


client_scripts {
    'config/client/**/*.lua',
    'client/**/*.lua',
}

lua54 "yes"