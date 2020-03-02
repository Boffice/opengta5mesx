ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

-- Pay for Healing
ESX.RegisterServerCallback('esx_advancedhospital:payHealing', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.getMoney() >= Config.HealingPrice then
		xPlayer.removeMoney(Config.HealingPrice)
		cb(true)
	else
		cb(false)
	end
end)

-- Pay for Surgery
ESX.RegisterServerCallback('esx_advancedhospital:paySurgery', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.getMoney() >= Config.SurgeryPrice then
		xPlayer.removeMoney(Config.SurgeryPrice)
		cb(true)
	else
		cb(false)
	end
end)

ESX.RegisterServerCallback('esx_advancedhospital:availableHealing', function(source, cb)
	-- checks number of medics online
	local xPlayers = ESX.GetPlayers()
	local medics = 0
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer.job.name == 'ambulance' then
			medics = medics + 1
		end
	end
	if medics < Config.MedicsOnLine then
		cb(true)
	else
		cb(false)
	end
end)