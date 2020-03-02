resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'ESX Wash Money'

version '1.0.0'

server_scripts {
	'@es_extended/locale.lua',
	'config.lua',
	'server.lua',
}

client_scripts {
	'@es_extended/locale.lua',
	'config.lua',
	'client.lua'
}

dependencies {
	'es_extended'
}