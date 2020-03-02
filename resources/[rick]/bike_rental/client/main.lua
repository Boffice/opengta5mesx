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

ESX          = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

local havebike = false

Citizen.CreateThread(function()

	if not Config.EnableBlips then return end
	
	for _, info in pairs(Config.BlipZones) do
		info.blip = AddBlipForCoord(info.x, info.y, info.z)
		SetBlipSprite(info.blip, info.id)
		SetBlipDisplay(info.blip, 4)
		SetBlipScale(info.blip, 1.0)
		SetBlipColour(info.blip, info.colour)
		SetBlipAsShortRange(info.blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(info.title)
		EndTextCommandSetBlipName(info.blip)
	end
end)



Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        for k in pairs(Config.MarkerZones) do
            DrawMarker(Config.TypeMarker, Config.MarkerZones[k].x, Config.MarkerZones[k].y, Config.MarkerZones[k].z, 0, 0, 0, 0, 0, 0, Config.MarkerScale.x, Config.MarkerScale.y, Config.MarkerScale.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, nil, nil, false)

		end
    end
end)


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
	
        for k in pairs(Config.MarkerZones) do
        	local ped = PlayerPedId()
            local pedcoords = GetEntityCoords(ped, false)
            local distance = Vdist(pedcoords.x, pedcoords.y, pedcoords.z, Config.MarkerZones[k].x, Config.MarkerZones[k].y, Config.MarkerZones[k].z)
            if distance <= 1.40 then
				if havebike == false then

					helptext(_U('press_e'))
					
					if IsControlJustPressed(0, Keys['E']) and IsPedOnFoot(ped) then
						OpenBikesMenu()
					end 
				elseif havebike == true then

					helptext(_U('storebike'))

					if IsControlJustPressed(0, Keys['E']) and IsPedOnAnyBike(ped) then

						TriggerEvent('esx:deleteVehicle')
					
						if Config.EnableEffects then
							ESX.ShowNotification(_U('bikemessage'))
						else
							TriggerEvent("chatMessage", _U('bikes'), {255,255,0}, _U('bikemessage'))
						end
						havebike = false
					else
						if Config.EnableEffects then
							ESX.ShowNotification(_U('notabike'))
						else
							TriggerEvent("chatMessage", _U('bikes'), {255,255,0}, _U('notabike'))
						end
					end 		
				end
			elseif distance < 1.45 then
				ESX.UI.Menu.CloseAll()
            end
        end
    end
end)


function OpenBikesMenu()
	local elements = {}
	for i=1, #Config.Bikes, 1 do
		local label = ''
		if Config.EnablePrice == true then
			label = 'Bike - <span style="color:green;">' .. Config.Bikes[i].name .. '</span> <span style="color:red;">' .. Config.Bikes[i].price .. '$</span>'
		else
			label = 'Bike - <span style="color:green;">' .. Config.Bikes[i].name
		end
		table.insert(elements, {label = label, value = i})
	end
	
	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open(
    'default', GetCurrentResourceName(), 'client',
    {
		title    = _U('biketitle'),
		align    = 'bottom-right',
		elements = elements,
    },
	
	
	function(data, menu)
		local bike = Config.Bikes[data.current.value]
		print("buying " .. bike.name)
		if Config.EnablePrice then
			TriggerServerEvent("esx:bike:rentbike", bike.name, bike.price)
		else
			TriggerServerEvent("esx:bike:rentbike", bike.name, 0)
		end
    end,
	function(data, menu)
		menu.close()
		end
	)
end

RegisterNetEvent('esx:bike:spawnbike')
AddEventHandler('esx:bike:spawnbike', function(bike)
	print("client event triggered spawning bike")
	if Config.EnableEffects then
			spawn_effect(bike)
		else
			TriggerEvent('esx:spawnVehicle', bike)
	end
	havebike = true
	ESX.UI.Menu.CloseAll()
end)

function helptext(text)
	SetTextComponentFormat('STRING')
	AddTextComponentString(text)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

function spawn_effect(somecar) 
	DoScreenFadeOut(1000)
	Citizen.Wait(1000)
	TriggerEvent('esx:spawnVehicle', somecar)
	DoScreenFadeIn(3000) 
end