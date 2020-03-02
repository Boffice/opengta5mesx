
resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'Custom Apartments By Rick'

server_scripts {
	'config.lua',
	'server/main.lua'
}

client_scripts {}

exports {}

server_exports {}

dependencies {
	'cron',
}