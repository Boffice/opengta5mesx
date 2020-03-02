ESX               = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer
end)

-----

RegisterNetEvent('usable_items:startSmoke')
AddEventHandler('usable_items:startSmoke', function(source)
	local playerPed = GetPlayerPed(-1)
	Citizen.CreateThread(function()
        TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_SMOKING", 0, true)
	end)
end)



----- General Animation
RegisterNetEvent('usable_items:playAnimation')
AddEventHandler('usable_items:playAnimation', function(source, animation)
	print(animation)
	local playerPed = GetPlayerPed(-1)
	Citizen.CreateThread(function()
        TaskStartScenarioInPlace(playerPed, animation, 0, true)
	end)
end)

