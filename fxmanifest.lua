fx_version 'cerulean'
games {'gta5'}
lua54 'yes'

autohr 'Schrottsoke660'
description 'Enter/Exit Vehicle Checker'
version '3.4.0'

shared_scripts {
    '@es_extended/imports.lua',
}

client_scripts {
    'client.lua'
}

server_scripts {
    'server.lua'
}

dependencies {
    'es_extended',
}