ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('esx_vehiclelock:requestPlayerCars', function(source, cb, plate)
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.fetchAll('SELECT 1 FROM owned_vehicles WHERE owner = @owner AND plate = @plate', {
		['@owner'] = xPlayer.identifier,
		['@plate'] = plate
	}, function(result)
		cb(result[1] ~= nil)
	end)
end)


RegisterServerEvent('esx_vehiclelock:save')
AddEventHandler('esx_vehiclelock:save', function(plate, position, heading)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	--local vehicules = getPlayerVehicles(xPlayer.getIdentifier())
	--local state = true
	local position = position
	local heading = heading
	local cur_time = os.time()
	local cur_datetime = os.date("%Y-%m-%d %X", cur_time)
	local last_active = cur_datetime
	-- local he = heal
	local plate = plate

	print("[esx_vechilelock] Saving: Plate1 -  " .. plate .. " Position - " .. json.encode(position) .. " Heading -" .. heading )
	print(json.encode(position))

	MySQL.Sync.execute("UPDATE owned_vehicles SET position =@position, heading=@heading, last_active=@last_active  WHERE plate=@plate",{['@position'] = json.encode(position) ,['@heading'] = heading, ['last_active'] = last_active, ['@plate'] = plate})


end)

RegisterServerEvent('esx_vehiclelock:vehicle_blip')
AddEventHandler('esx_vehiclelock:vehicle_blip', function(plate)
	local _source = source
	print('[esx_vehiclelock:vehicle_blip]' .. _source)
	MySQL.Async.fetchAll("SELECT plate, position FROM owned_vehicles WHERE plate = @plate", {['@plate'] = plate},
			function(results)
				print('[esx_vehiclelock:vehicle_blip] source? ' .. _source)
				--local xx = MySQL.Sync.fetchScalar("SELECT x FROM owned_vehicles WHERE plate = @plate", {['@plate'] = plate})
				--local yy = MySQL.Sync.fetchScalar("SELECT y FROM owned_vehicles WHERE plate = @plate", {['@plate'] = plate})
				--local zz = MySQL.Sync.fetchScalar("SELECT z FROM owned_vehicles WHERE plate = @plate", {['@plate'] = plate})
				--if xx ~= nil and yy ~= nil and zz ~= nil then
				if #results then
					local position = results[1].position
					local plate = results[1].plate
					if position then
						print('[esx_vehiclelock:vehicle_blip]: Vehicle position for plate : ' .. plate .. " -- " .. position)
						print(_source)
						print(position)
						TriggerClientEvent('esx_vehiclelock:set_vehicle_blip', _source, json.decode(position))
						TriggerClientEvent('esx:showNotification', _source, "Car blip added to map")
					else
						print('[esx_vehiclelock:vehicle_blip]: Vehicle position for plate : ' .. plate .. ' is null in DB.')
						TriggerClientEvent('esx:showNotification', _source, "Unknown position. Pls contact police (or admin) to report lost or stolen vehicle.")

					end
				else
					print('[esx_vehiclelock:vehicle_blip]: Vehicle not in DB ??)')
					TriggerClientEvent('esx:showNotification', _source, "Invalid plate.")

				end
			end)
end)



