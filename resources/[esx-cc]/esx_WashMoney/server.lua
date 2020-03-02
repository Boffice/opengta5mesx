ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent("esx_WashMoney:wash")
AddEventHandler('esx_WashMoney:wash', function()

	local xPlayer = ESX.GetPlayerFromId(source) -- Gets the players data
	local money = xPlayer.getMoney() -- gets normal money
	local black_money_amount = xPlayer.getAccount('black_money').money

	xPlayer.addMoney(black_money_amount) -- Adds the normal money
	xPlayer.removeAccountMoney('black_money', black_money_amount) -- Removes Dirty Money

	TriggerClientEvent('esx:showNotification', source, "You have your dirty money!")

end)