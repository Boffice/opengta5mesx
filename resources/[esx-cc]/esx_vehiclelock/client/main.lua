ESX               = nil

local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

local isRunningWorkaround = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

function StartWorkaroundTask()
	if isRunningWorkaround then
		return
	end

	local timer = 0
	local playerPed = PlayerPedId()
	isRunningWorkaround = true

	while timer < 100 do
		Citizen.Wait(0)
		timer = timer + 1

		local vehicle = GetVehiclePedIsTryingToEnter(playerPed)

		if DoesEntityExist(vehicle) then
			local lockStatus = GetVehicleDoorLockStatus(vehicle)

			if lockStatus == 4 then
				ClearPedTasks(playerPed)
			end
		end
	end

	isRunningWorkaround = false
end

function RVehicleLock(vehicle)
	local lockStatus = GetVehicleDoorLockStatus(vehicle)
	local plate = GetVehicleNumberPlateText(vehicle)
	--local position = GetEntityCoords(vehicle)
	--local positon_vector = GetEntityCoords(vehicle)
	local x,y,z = table.unpack(GetEntityCoords(vehicle))
	-- ESX.Math.Round(self.lastPosition.x, 1)
	local position = {x = ESX.Math.Round(x, 1), y = ESX.Math.Round(y, 1), z = ESX.Math.Round(z, 1)}
	local heading = GetEntityHeading(vehicle)

	print("[esx_vechilelock] Saving: Plate1 -  " .. plate .. " Position - " .. json.encode(position) .. " Heading -" .. heading )
	if lockStatus == 1 then -- unlocked
		SetVehicleDoorsLocked(vehicle, 4)
		PlayVehicleDoorCloseSound(vehicle, 1)
		-- TriggerServerEvent("esx_vehiclelock:save", plate, position, heading)

		TriggerEvent('chat:addMessage', { args = { _U('message_title'), _U('message_locked') } })
	elseif lockStatus == 4 then -- locked
		SetVehicleDoorsLocked(vehicle, 1)
		PlayVehicleDoorOpenSound(vehicle, 0)
		--TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 3, "unlock", 1.0)
		-- TriggerServerEvent("esx_vehiclelock:save", plate, position, heading)
		TriggerEvent('chat:addMessage', { args = { _U('message_title'), _U('message_unlocked') } })
	else
		TriggerEvent('chat:addMessage', { args = {'message title', 'not sure if locked or nor' } })
	end

	TriggerServerEvent("esx_vehiclelock:save", plate, position, heading)
end

function ToggleVehicleLock()
	local playerPed = PlayerPedId()
	local ped = GetPlayerPed(-1)
	local coords = GetEntityCoords(playerPed)
	print(type(coords))
	local vehicle

	Citizen.CreateThread(function()
		StartWorkaroundTask()
	end)

	if IsPedInAnyVehicle(playerPed, false) then
		vehicle = GetVehiclePedIsIn(playerPed, false)
	else
		vehicle = GetClosestVehicle(coords, 8.0, 0, 70)
	end

	if not DoesEntityExist(vehicle) then
		return
	end

	local vehiclePropsn  = ESX.Game.GetVehicleProperties(vehicle)
	--print(vehiclePropsn.plate)
	print("[esx_vechilelock] Plate: " .. vehiclePropsn.plate)
	print("[esx_vechilelock] Plate1: " .. GetVehicleNumberPlateText(vehicle))
	ESX.TriggerServerCallback('esx_vehiclelock:requestPlayerCars', function(isOwnedVehicle)
		local lockStatus = GetVehicleDoorLockStatus(vehicle)

		if isOwnedVehicle then

			print("[esx_vechilelock] lock/unlock presses getting vechile coords: " .. vehicle)
			print("[esx_vechilelock] player coords: " .. coords)

			print("[esx_vechilelock] lock status: " .. lockStatus)


			if IsPedInAnyVehicle(ped) then
				RVehicleLock(vehicle)
			else
				--ANIMATION------------------------------
				RequestModel(GetHashKey("p_car_keys_01"))
				while not HasModelLoaded(GetHashKey("p_car_keys_01")) do
					Citizen.Wait(100)
					print("[esx_vechilelock] waiting on animation: ")
				end

				print("[esx_vechilelock] got animation: ")

				local plyCoords = GetOffsetFromEntityInWorldCoords(ped, 0.0, 0.0, -5.0)
				print(type(plyCoords))
				local micspawned = CreateObject(GetHashKey("p_car_keys_01"), plyCoords.x, plyCoords.y, plyCoords.z, 1, 1, 1)
				local netid = ObjToNet(micspawned)
				SetNetworkIdExistsOnAllMachines(netid, true)
				NetworkSetNetworkIdDynamic(netid, true)
				SetNetworkIdCanMigrate(netid, false)
				AttachEntityToEntity(micspawned, ped, GetPedBoneIndex(ped, 28422), 0.055, 0.05, 0.0, 240.0, 0.0, 0.0, 1, 1, 0, 1, 0, 1)

				print("[esx_vechilelock] done setting up sound ")

				ESX.Streaming.RequestAnimDict("anim@mp_atm@enter", function()
					TaskPlayAnim(ped, "anim@mp_atm@enter", "enter", 8.0, -8.0, -1, 0, 0, false, false, false)
					Citizen.Wait(1000)
					RVehicleLock(vehicle)
					Citizen.Wait(3000)
				end)

				ClearPedSecondaryTask(ped)
				DetachEntity(NetToObj(netid), 1, 1)
				DeleteEntity(NetToObj(netid))
			end
		else
			print(('[esx_vechilelock] [^2INFO^7] "%s" trying to lock/unlock unowned vehicle!'):format(ped))
			if IsPedInAnyVehicle(ped) then
				print(('[esx_vechilelock] [^2INFO^7] "%s" is inside vehicle. OK - allowed'):format(ped))
				RVehicleLock(vehicle)
			else
				print(('[esx_vechilelock] [^2INFO^7] "%s" Not in vehicle, not owned. DENIED!!'):format(ped))
			end
		end

	end, ESX.Math.Trim(GetVehicleNumberPlateText(vehicle)))
end


RegisterNetEvent('esx_vehiclelock:get_vehicle_blip')
AddEventHandler('esx_vehiclelock:get_vehicle_blip', function(plate)
	print('[esx_vehiclelock:get_vehicle_blip] Source: ' .. source)
	TriggerServerEvent('esx_vehiclelock:vehicle_blip', plate)
end)

blipm = nil
RegisterNetEvent('esx_vehiclelock:set_vehicle_blip')
AddEventHandler('esx_vehiclelock:set_vehicle_blip', function(position)
	print('[esx_vehiclelock:set_vehicle_blip] Position: ' .. position.x .. ", " .. position.y .. ", " .. position.z)

	local xxx = position.x + 0.0
	local zzz = position.z + 0.0
	local yyy = position.y + 0.0
	print("remove old blip")
	RemoveBlip(blipm)
	print("removed")
	blipm = AddBlipForCoord(xxx, yyy, zzz)

	SetBlipSprite (blipm, 326)
	SetBlipDisplay(blipm, 4)
	SetBlipScale  (blipm, 0.8)
	SetBlipColour (blipm, 2)
	SetBlipAsShortRange(blipm, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Car")
	EndTextCommandSetBlipName(blipm)
end)


-- Set custom blip
cblipm = nil
RegisterNetEvent('esx_vehiclelock:set_custom_blip')
AddEventHandler('esx_vehiclelock:set_custom_blip', function(position)
	print('[esx_vehiclelock:set_custom_blip] Position: ' .. position.x .. ", " .. position.y .. ", " .. position.z)

	local xxx = position.x + 0.0
	local zzz = position.z + 0.0
	local yyy = position.y + 0.0
	print("remove old blip")
	RemoveBlip(cblipm)
	print("removed")
	cblipm = AddBlipForCoord(xxx, yyy, zzz)

	SetBlipSprite (cblipm, 66)
	SetBlipDisplay(cblipm, 4)
	SetBlipScale  (cblipm, 1.2)
	SetBlipColour (cblipm, 59)
	SetBlipAsShortRange(cblipm, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Custom")
	EndTextCommandSetBlipName(cblipm)
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)

		if IsControlJustReleased(0, Keys['U']) and IsInputDisabled(0) then
			ToggleVehicleLock()
			Citizen.Wait(300)

			-- D-pad down on controllers works, too!
		elseif IsControlJustReleased(0, 173) and not IsInputDisabled(0) then
			ToggleVehicleLock()
			Citizen.Wait(300)
		end
	end
end)
