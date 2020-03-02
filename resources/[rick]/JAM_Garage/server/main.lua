TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)	

function JAM_Garage:GetPlayerVehicles(identifier)	
	local playerVehicles = {}
        print("[JAM_Garage] identifier: " .. identifier)
	local data = MySQL.Sync.fetchAll("SELECT * FROM owned_vehicles WHERE owner=@identifier",{['@identifier'] = identifier})	
	for key,val in pairs(data) do
                print("[JAM_Garage] key: " .. key )
                print("[JAM_Garage] val: " .. val.plate )
		if val.job == nil then
			local playerVehicle = json.decode(val.vehicle)
			table.insert(playerVehicles, {owner = val.owner, veh = val.vehicle, vehicle = playerVehicle, plate = val.plate, state = val.jamstate})
		end
	end
	return playerVehicles
end

ESX.RegisterServerCallback('JAM_Garage:StoreVehicle', function(source, cb, vehicleProps)
	local isFound = false
	local xPlayer = ESX.GetPlayerFromId(source)
	while not xPlayer do
		xPlayer = ESX.GetPlayerFromId(source)
		Citizen.Wait(0)
	end

	local playerVehicles = JAM_Garage:GetPlayerVehicles(xPlayer.getIdentifier())
	local plate = vehicleProps.plate

	for key,val in pairs(playerVehicles) do
		if(plate == val.plate) then
			local vehProps = json.encode(vehicleProps)
			MySQL.Sync.execute("UPDATE owned_vehicles SET vehicle=@vehProps WHERE plate=@plate",{['@vehProps'] = vehProps, ['@plate'] = val.plate})
			isFound = true
			break
		end
	end
	cb(isFound)
end)

ESX.RegisterServerCallback('JAM_Garage:GetVehicles', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	while not xPlayer do
		xPlayer = ESX.GetPlayerFromId(source)
		Citizen.Wait(0)
	end
	local vehicles = JAM_Garage:GetPlayerVehicles(xPlayer.getIdentifier())
	cb(vehicles)
end)


ESX.RegisterServerCallback('JAM_Garage:FinePlayer', function(source, cb, amount)
	local xPlayer = ESX.GetPlayerFromId(source)
	while not xPlayer do
		xPlayer = ESX.GetPlayerFromId(source)
		Citizen.Wait(0)
	end
	print(xPlayer.getMoney())
	print(amount)
	if xPlayer.getMoney() > amount then
		xPlayer.removeMoney(amount)
		cb(true)
	else
		cb(false)
	end
end)

RegisterNetEvent('JAM_Garage:ChangeState')
AddEventHandler('JAM_Garage:ChangeState', function(plate, state)
	local xPlayer = ESX.GetPlayerFromId(source)
	while not xPlayer do
		xPlayer = ESX.GetPlayerFromId(source)
		Citizen.Wait(0)
	end

	local vehicles = JAM_Garage:GetPlayerVehicles(xPlayer.getIdentifier())
	for key,val in pairs(vehicles) do
		if(plate == val.plate) then
			MySQL.Sync.execute("UPDATE owned_vehicles SET jamstate=@state WHERE plate=@plate",{['@state'] = state , ['@plate'] = plate})
			break
		end		
	end
end)

function JAM_Garage.Startup()
	--[[
    local dbconfig  =
    {
      ["@dbname"]	= JAM_Garage.Config.DBName,
      ["@dbtable@"] = "owned_vehicles",
      ["@dbfield@"] = "jamstate",
      ["@dbfieldconf@"] = "int(11) NOT NULL DEFAULT 0",
    }

    local query1 = "SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA ='@dbname' and COLUMN_NAME='@dbfield@' and TABLE_NAME='@dbtable@';"
    local query2 = "ALTER TABLE `@dbtable@` ADD COLUMN `@dbfield@` @dbfieldconf@;"

    local curquery1 = JAM_Garage.Replace(dbconfig,query1)
    local curquery2 = JAM_Garage.Replace(dbconfig,query2)

    local data = MySQL.Sync.fetchAll( curquery1 )
    if #data == 0 then  MySQL.Sync.fetchAll( curquery2 );  end;
    ]]--
end

function JAM_Garage.Replace(c,q)
    for repThis,repWith in pairs(type(c) == "table" and c or {}) do q = tostring(q):gsub(repThis,repWith); end;
    return q
end

RegisterNetEvent('JAM_Garage:Startup')
AddEventHandler('JAM_Garage:Startup', JAM_Garage.Startup)



-- Reset all owned vehicles on server restart
MySQL.ready(function()
	local jamstate = 1
	local jamstaretext = "garage"
	if JAM_Garage.Config.UseImpound == true then
		janstate = 2
		jamstatetext = "impound"
	end
	print("[JAM Garage] [^2INFO^7] MySQL Ready, putting all car in police station or " .. jamstaretext .. " if they are out")
	MySQL.Async.execute("UPDATE owned_vehicles SET owned_vehicles.stored = 1, owned_vehicles.jamstate = 1  WHERE job=@job", {['@job'] = "police"})
	MySQL.Async.execute("UPDATE owned_vehicles SET owned_vehicles.stored = 1, owned_vehicles.jamstate = 1  WHERE job=@job", {['@job'] = "ambulance"})
	MySQL.Async.execute("UPDATE owned_vehicles SET owned_vehicles.stored = 1, owned_vehicles.jamstate = 1  WHERE job=@job", {['@job'] = "mechanic"})


	MySQL.Async.execute("UPDATE owned_vehicles SET owned_vehicles.jamstate=@jamstate WHERE job IS NULL and owned_vehicles.jamstate = 0", {['@jamstate'] = jamstate})
	if JAM_Garage.Config.UseImpound == false then
		MySQL.Async.execute("UPDATE owned_vehicles SET owned_vehicles.jamstate=@jamstate WHERE job IS NULL and owned_vehicles.jamstate = 2", {['@jamstate'] = jamstate})
	end

end)