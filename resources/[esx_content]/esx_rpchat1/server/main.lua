
-- ############################################
-- --------------------------------------------
-- 3dme : /me command but its 3D printed
-- Author : Elio + ESX
-- Server side
-- --------------------------------------------
-- ############################################

-- --------------------------------------------
-- Functions
-- --------------------------------------------

-- OBJ : transform a table into a string (using spaces)
-- PARAMETERS :
--		- tab : the table to transform
local function TableToString(tab)
	local str = ""
	for i = 1, #tab do
		str = str .. " " .. tab[i]
	end
	return str
end

-- --------------------------------------------
-- Init
-- --------------------------------------------

ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

AddEventHandler('es:invalidCommandHandler', function(source, command_args, user)
	CancelEvent()
	TriggerClientEvent('chat:addMessage', source, {args = {'^1SYSTEM', _U('unknown_command', command_args[1])}})
end)

AddEventHandler('chatMessage', function(playerId, playerName, message)
	if string.sub(message, 1, string.len('/')) ~= '/' then
		CancelEvent()

		local xPlayer = ESX.GetPlayerFromId(playerId)
		if xPlayer then playerName = xPlayer.getName() end
		TriggerClientEvent('chat:addMessage', -1, {args = {_U('ooc_prefix', playerName), message}, color = {128, 128, 128}})
	end
end)

-- --------------------------------------------
-- Commands
-- --------------------------------------------

RegisterCommand('twt', function(playerId, args, rawCommand)
	if playerId == 0 then
		print('esx_rpchat: you can\'t use this command from console!')
	else
		args = table.concat(args, ' ')
		local playerName = GetRealPlayerName(playerId)

		TriggerClientEvent('chat:addMessage', -1, {args = {_U('twt_prefix', playerName), args}, color = {0, 153, 204}})
	end
end, false)

--[[ old version
RegisterCommand('me', function(playerId, args,
	if source == 0 then
		print('esx_rpchat: you can\'t use this command from console!')
	else
		args = table.concat(args, ' ')
		local playerName = GetRealPlayerName(playerId)

		TriggerClientEvent('esx_rpchat:sendProximityMessage', -1, source, _U('me_prefix', playerName), args, {255, 0, 0})
	end
end, false)
]] --

RegisterCommand('me', function(playerId, args, rawCommand)
	print(source)
	print(playerId)
	print(args)
	if source == 0 then
		print('[esx_rpchat] [^3WARNING^7] : you can\'t use this command (\\me) from console!')
	else
		if Config.ShowAboveHead then
			local text = "* the person" .. TableToString(args) .. " *" -- could you just use table.concat(args, ' ')
			print(text)
			TriggerClientEvent('esx_rpchat:shareDisplay', -1, text, source)
		end
		if Config.ShowInChat then
			args = table.concat(args, ' ')
			local playerName = GetRealPlayerName(playerId)
			TriggerClientEvent('esx_rpchat:sendProximityMessage', -1, source, _U('me_prefix', playerName), args, {255, 0, 0})
		end
	end
end)

RegisterCommand('do', function(playerId, args, rawCommand)
	if source == 0 then
		print('esx_rpchat: you can\'t use this command from console!')
	else
		args = table.concat(args, ' ')
		local playerName = GetRealPlayerName(playerId)

		TriggerClientEvent('esx_rpchat:sendProximityMessage', -1, source, _U('do_prefix', playerName), args, {0, 0, 255})
	end
end, false)

function GetRealPlayerName(playerId)
	local xPlayer = ESX.GetPlayerFromId(playerId)

	if xPlayer then
		if Config.EnableESXIdentity then
			if Config.OnlyFirstname then
				return xPlayer.get('firstName')
			else
				return xPlayer.getName()
			end
		else
			return xPlayer.getName()
		end
	else
		return GetPlayerName(playerId)
	end
end
