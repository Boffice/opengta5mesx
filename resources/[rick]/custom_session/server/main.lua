--[[

Put Description here

]]--

ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


-- Removes Apartment when player is disconnect or dropped
AddEventHandler('playerDropped', function(reason)
	local _source = source
	print("custom_sessions: player dropped")
	local id
	for k, v in ipairs(GetPlayerIdentifiers(_source)) do
		if string.match(v, 'license:') then
			id = string.sub(v, 9)
			break
		end
	end

	if id then
		print("custom_sessions: player dropped " .. id)

		local cur_time = os.time()
		local cur_datetime = os.date("%Y-%m-%d %X", cur_time)
		print(cur_datetime)
		MySQL.Async.execute('UPDATE users SET last_logout = @last_logout WHERE identifier = @identifier',
				{
					['@last_logout'] = cur_datetime,
					['@identifier']    = id
				})
	end

end)


-- When a user connects, add temp apartment for the user
AddEventHandler('playerConnecting', function(name, setKickReason)
	local _source = source
	print("custom_sessions: player connecting")
	local id
	for k, v in ipairs(GetPlayerIdentifiers(_source)) do
		if string.match(v, 'license:') then
			id = string.sub(v, 9)
			break
		end
	end

	if id then
		print("custom_sessions: player connecting " .. id)
		local cur_time = os.time()
		local cur_datetime = os.date("%Y-%m-%d %X", cur_time)
		print(cur_datetime)
		MySQL.Async.execute('UPDATE users SET last_login = @last_login WHERE identifier = @identifier',
				{
					['@last_login'] = cur_datetime,
					['@identifier']    = id
				})

	end
end)
