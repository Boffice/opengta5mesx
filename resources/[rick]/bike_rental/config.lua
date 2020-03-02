Config                            = {}
Config.Locale                     = 'en'

--- #### BASICS
Config.EnablePrice = true -- false = bikes for free
Config.EnableEffects = true
Config.EnableBlips = true

--- #### BIKE and PRICES, must match DB
Config.Bikes = {
    {name = "cruiser", price = 50},
    {name = "bmx", price = 60},
    {name = "scorcher", price = 70},
    {name = "fixter", price = 150},
    {name = "tribike3", price = 160},
}


--- #### MARKER EDITS
Config.TypeMarker = 1
Config.MarkerScale = {x = 2.000,y = 2.000,z = 0.500}
Config.MarkerColor = {r = 102, g = 102, b = 204}
	
Config.MarkerZones = { 

    --{x = -246.980,y = -339.820,z = 29.000},
    --{x = -6.986,y = -1081.704,z = 25.7},
    --{x = -1085.78,y = -263.01,z = 36.80},
    -- Bike shop @ beach
    {x = -1262.36,y = -1438.98,z = 3.45},
    -- Apartments
    {x = 285.64,y = -224.5,z = 53.1},
    -- Job Center
    {x = -231.82,y = -963.68,z =28.5},
    -- Airport
    {x = -1019.12,y = -2689.67,z =13.2},
    -- Hospital
    {x = 287.46,y = -615.49,z =42.6},


}


-- Edit blip titles
Config.BlipZones = {
   --{title="Bikes Rental", colour=2, id=376, x = -248.938, y = -339.955, z = 29.969},
   --{title="Bikes Rental", colour=2, id=376, x = -6.892, y = -1081.734, z = 26.829},
   {title="Bikes Rental", colour=2, id=376, x = -1262.36, y = -1438.98, z = 3.45},
   {title="Bikes Rental", colour=2, id=376, x = 285.64, y = -224.5, z = 53.1},
   {title="Bikes Rental", colour=2, id=376, x=-231.82,y = -963.68,z =28.5},
   {title="Bikes Rental", colour=2, id=376, x = -1019.12,y = -2689.67,z =13.2},
   {title="Bikes Rental", colour=2, id=376, x = 287.46,y = -615.49,z =42.6},

}
