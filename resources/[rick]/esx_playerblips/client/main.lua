ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end
	ESX.PlayerData = ESX.GetPlayerData()
    local blips = {}
	local currentPlayer = PlayerId()-- Is the player a cop? In that case show all the blips for other cops
	while true do
		Wait(30000)
        for _,v in pairs(Config.ShowBlipsFor) do
			print(ESX.PlayerData.identifier)
            if ESX.PlayerData.identifier == v then
                print("esx_playerblips:showing blips for admin")
		        ESX.TriggerServerCallback('esx_society:getOnlinePlayers', function(players)
		            print("esx_playerblips: Num of players - " .. #players)
			        for i=1, #players, 1 do
				        RemoveBlip(blips[i])
					    local id = GetPlayerFromServerId(players[i].source)
					    if NetworkIsPlayerActive(id) then
						    createBlip(id,i)
					    end
			        end
		        end)
		    end
		end
    end
end)

-- Create blip for colleagues
function createBlip(id)
	local ped = GetPlayerPed(id)
	local blip = GetBlipFromEntity(ped)

	if not DoesBlipExist(blip) then -- Add blip and create head display on player
		blip = AddBlipForEntity(ped)
		SetBlipSprite(blip, 1)
		ShowHeadingIndicatorOnBlip(blip, true) -- Player Blip indicator
		SetBlipRotation(blip, math.ceil(GetEntityHeading(ped))) -- update rotation
		SetBlipNameToPlayerName(blip, id) -- update blip name
		SetBlipScale(blip, 0.85) -- set scale
		SetBlipAsShortRange(blip, true)

		--table.insert(blips, blip) -- add blip to array so we can remove it later
		blips[id] = new_blip
	end
end