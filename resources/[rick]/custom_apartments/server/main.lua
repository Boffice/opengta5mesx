--[[

On login a user is given an apartment in the "apartment complex" this file handles underlying server logic
    - rents a random apartment to a user
    - sets the users last apartment to that apartment
    - on disconnect it removes the apartment from the user

]]--

ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

-- LOG_OUT_TIMER = 120 -- in seconds
LOG_OUT_TIMER = Config.TimeOut

-- TODO
-- on server (re)start remove all temp apartments from database.
MySQL.ready(function()
	print("[custom_apartments] MySQL Ready, this is only on server restart.")
        MySQL.Async.execute('DELETE FROM owned_properties WHERE name = @name',
	    {
		['@name']  = 'MotelRoom'
	    }, function(rowsChanged)
		print("deleted temp aprat in DB")
	end)
end)

-- Removes a Temp Apartment
function RemoveTempApartment(owner)
    print("Removing Temp Apart for: " .. owner )
	local prop_name = "MotelRoom"
    print("Removing Temp Apart " .. prop_name .. " for: " .. owner )
	TriggerEvent('esx_property:removeOwnedPropertyNew', prop_name, owner)
end


-- Looks through all property that has storage space and get a random unused one
function GetRandomUnOwnedProperty()
    print("Getting unused Temp Apart")
    local props = MySQL.Sync.fetchAll('SELECT properties.name, properties.room_menu FROM properties LEFT JOIN owned_properties ON properties.NAME=owned_properties.name WHERE properties.`room_menu` IS NOT NULL AND owned_properties.OWNER IS NULL', {})
	local n = math.random(#props)
    print("Unused prop number " .. n .. "(random) - ".. props[n].name .. " @ " .. props[n].room_menu)
    return(props[n])
end


-- Assigns a user a temp apartment
function AddTempApartment(owner)
	local property = "MotelRoom"
	print(('[custpm_apartments] [^2INFO^7]: setting Temp Apart "%s" for: "%s"'):format(property, owner))
    -- print("Setting Temp Apart " .. property .. " for: " .. owner )
	TriggerEvent('esx_property:setPropertyOwned', property, 0, 1, owner)
	return property
end


-- Removes Apartment when player is disconnect or dropped
AddEventHandler('playerDropped', function(reason)
	local _source = source
	print("custom apartments:  player dropped")
	local id
	for k, v in ipairs(GetPlayerIdentifiers(_source)) do
		if string.match(v, 'license:') then
			id = string.sub(v, 9)
			break
		end
	end

	if id then
		print("custom apartments: player dropped " .. id)
		RemoveTempApartment(id)
	end

end)


-- When a user connects, add temp apartment for the user
AddEventHandler('playerConnecting', function(name, setKickReason)
	print("custom apartments: player connecting: " .. name)
    local id
	for k,v in ipairs(GetPlayerIdentifiers(source))do
		if string.match(v, 'license:') then
			id = string.sub(v, 9)
			break
		end
	end
	if id then
		-- local prop = AddTempApartment(id)
		-- add temp apartment if not already rented

		local owned_apt = MySQL.Sync.fetchAll('SELECT * FROM owned_properties WHERE name = "MotelRoom" and owner = @identifier', {['@identifier'] = id})
		local prop_name = "MotelRoom"
		if #owned_apt == 0 then
			prop_name = AddTempApartment(id)
		end
		-- if reloggin within in 2mins do nothing, other wise spawn at apartment
		local sessions = MySQL.Sync.fetchAll('SELECT last_logout FROM users WHERE identifier = @identifier', {['@identifier'] = id,})
		print("custom_apartments: LAST LOG")
		print("custom_apartments: " .. #sessions)

		if #sessions == 0 then
			-- first time logging in
			print("custom_apartments: first time logging in, not setting spawn to apts")
		else
			-- check to see if alredy in a property
			local last_prop = MySQL.Sync.fetchAll('SELECT last_property FROM users WHERE identifier = @identifier',
							{
								['@identifier']    = id
							})
			print(last_prop[1])
			print(last_prop[1].last_property)
			if last_prop[1].last_property then
				print(('[custpm_apartments] [^2INFO^7]: already in last_porp: %s'):format(last_prop[1].last_property))
			else
				-- no last prop, set to apartmen
				local last_logout = sessions[1].last_logout / 1000 -- need to change from mili second to seconds
				if last_logout then
					print("custom_apartments: last logout : " .. last_logout)
					--[[
                    local pattern = "(%d+)-(%d+)-(%d+) (%d+):(%d+):(%d+)"
                    local runyear, runmonth, runday, runhour, runminute, runseconds = last_logout:match(pattern)
                    last_logout = os.time({year = runyear, month = runmonth, day = runday, hour = runhour, min = runminute, sec = runseconds})
                    ]] --
					local t = os.time() - last_logout
					print(os.time())
					print(last_logout)
					print(type(last_logout))
					print("custom_apartments: time diff " .. t)
					if os.time() - last_logout > LOG_OUT_TIMER then
						print("custom_apartments: last logout over" .. LOG_OUT_TIMER .. "ago")
						print("custom_apartments: setting last property of " .. id .. " to " .. prop_name)
						MySQL.Async.execute('UPDATE users SET last_property = @last_property WHERE identifier = @identifier',
							{
								['@last_property'] = prop_name,
								['@identifier'] = id
							})
						print("custom_apartments: temp apartment added...hopefully ;) ")
					else
						print("custom_apartments: last logout under " .. LOG_OUT_TIMER .. " ago (or null), not setting spawn to apartment")
					end
				end
			end
		end
	end
end)
