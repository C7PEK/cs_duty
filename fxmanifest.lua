fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'c7pek'
description 'cs_duty pod Target. Support -> https://discord.gg/wtuc73KNDu'
version '1.0'

client_scripts{
    'config.lua',
    'client/main.lua'
}

server_scripts{
    'config.lua',
    '@oxmysql/lib/MySQL.lua',
    'server/main.lua'
}

shared_scripts {
    '@ox_lib/init.lua',
}