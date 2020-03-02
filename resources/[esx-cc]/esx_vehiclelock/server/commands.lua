TriggerEvent('es:addCommand', 'findcar', function(source, args, user)
    if args[1] then
        print(source)
        print(args[1])
        print(user)
        local xPlayer1 = ESX.GetPlayerFromId(source)
        local plate = args[1]

        if xPlayer1 then
            -- TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'That job does not exist.' } })
            TriggerClientEvent('esx_vehiclelock:get_vehicle_blip', source, plate)
        else
            TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Player not online.' } })
        end
    else
        TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Invalid usage.' } })
    end
end, {help = 'findcar', params = {{name = "plate", help = 'reg plate of the car'}}})


cblipm = nil
TriggerEvent('es:addCommand', 'setblip', function(source, args, user)
    if tonumber(args[1]) and tonumber(args[2]) and tonumber(args[3]) then
        x = tonumber(args[1]) + 0.0
        y = tonumber(args[2]) + 0.0
        z = tonumber(args[3]) + 0.0
        print(source)
        print(x)
        print(y)
        print(z)
        print(user)
        position = {x=x, y=y, z=z}
        TriggerClientEvent('esx_vehiclelock:set_custom_blip', source, position)
        TriggerClientEvent('esx:showNotification', source, "Custom blip added to map: ?")
    else
        TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Invalid usage.' } })
    end
end, {help = 'set a blip on your map', params = {{name = "x", help = 'x coords'}, {name = "y", help = 'y coords'}, {name = "z", help = 'z coords'}}})