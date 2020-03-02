--Truck
Config	=	{}

 -- Limit, unit can be whatever you want. Originally grams (as average people can hold 25kg)
Config.Limit = 50000

-- Default weight for an item:
	-- weight == 0 : The item do not affect character inventory weight
	-- weight > 0 : The item cost place on inventory
	-- weight < 0 : The item add place on inventory. Smart people will love it.
Config.DefaultWeight = 0



-- If true, ignore rest of file
Config.WeightSqlBased = false

-- I Prefer to edit weight on the config.lua and I have switched Config.WeightSqlBased to false:

Config.localWeight = {
	bread = 125,
	water = 330,
	WEAPON_COMBATPISTOL = 1000, -- weight for munnition
	black_money = 0.5, -- Weight for money
}

Config.VehicleLimit = {
    [0] = 70000, --Compact
    [1] = 100000, --Sedan
    [2] = 150000, --SUV
    [3] = 70000, --Coupes
    [4] = 100000, --Muscle
    [5] = 70000, --Sports Classics
    [6] = 10000, --Sports
    [7] = 5000, --Super
    [8] = 5000, --Motorcycles
    [9] = 180000, --Off-road
    [10] = 300000, --Industrial
    [11] = 100000, --Utility
    [12] = 500000, --Vans
    [13] = 0, --Cycles
    [14] = 125000, --Boats
    [15] = 20000, --Helicopters
    [16] = 0, --Planes
    [17] = 200000, --Service
    [18] = 200000, --Emergency
    [19] = 0, --Military
    [20] = 300000, --Commercial
    [21] = 0, --Trains
}