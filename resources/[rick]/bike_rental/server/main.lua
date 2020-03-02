ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

Citizen.CreateThread(function()
	Citizen.Wait(5000)
	local ver = "5.0"
	print("ESX Bike Rental started v"..ver)
end)


RegisterServerEvent('esx:bike:rentbike')
AddEventHandler('esx:bike:rentbike', function(bike, price)
	print("buying " .. bike)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	-- can the player afford the bike?
	if xPlayer.getMoney() >= price then
		print("can afford, ok")
		xPlayer.removeMoney(price)
		TriggerClientEvent('esx:showNotification', _source, _U('bought', amount, bike, ESX.Math.GroupDigits(price)))
		TriggerClientEvent('esx:bike:spawnbike', _source, bike)

	else
		print("can NOT afford")
		local missingMoney = price - xPlayer.getMoney()
		TriggerClientEvent('esx:showNotification', _source, _U('not_enough', ESX.Math.GroupDigits(missingMoney)))
	end
end)
