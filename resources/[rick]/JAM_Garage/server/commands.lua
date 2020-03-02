
ESX.RegisterCommand(
    {'dv'},
    'user',
    function(xPlayer, args, showError)
        xPlayer.triggerEvent('JAM_Garage:StoreVehicleClient', 1)
    end,
    false,
    {
        help = _U('store_car'),
        validate = false
    }
)