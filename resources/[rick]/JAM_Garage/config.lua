JAM_Garage = {
	Config = {	
		DBName					= "",
		MarkerDrawDistance 		= 100,
		VehicleDespawnDistance 	= 500,
		UseImpound				= false,
		ImpoundCost 			= 1000,
		ImpoundTime             = 600, -- impound after this time
		RepairCost		 		= 0,

		Blips = {
			CityGarage = {
				Zone = "Garage",
				Sprite = 50,
				Scale = 0.8,
				Display = 4,
				Color = 68,
				Pos = { x = 227.50, y = -793.30, z = 30.60 },
			},			
			VehicleStoreGarage = {
				Zone = "Garage",
				Sprite = 50,
				Scale = 0.8,
				Display = 4,
				Color = 68,
				Pos = { x = -66.54, y = -1165.96, z = 25.00 },
			},
			CityImpound = {
				Zone = "Impound",
				Sprite = 67,
				Scale = 0.8,
				Display = 4,
				Color = 47,
				Pos = { x = 491.90, y = -1315.00, z = 29.25 },
			},
			PaletoGarage = {
				Zone = "Garage",
				Sprite = 50,
				Scale = 0.8,
				Display = 4,
				Color = 68,
				Pos = { x = 105.35, y = 6613.58, z = 31.39 },
			},			
			PaletoImpound = {
				Zone = "Impound",
				Sprite = 67,
				Scale = 0.8,
				Display = 4,
				Color = 47,
				Pos = { x = -458.17, y = 6024.81, z = 31.40 },
			},			
			MedicalTowerGarage = {
				Zone = "Garage",
				Sprite = 50,
				Scale = 0.8,
				Display = 4,
				Color = 68,
				Pos = { x = -654.77, y = 310.27, z = 82.97 },
			},	
			SandyShoresGarage = {
				Zone = "Garage",
				Sprite = 50,
				Scale = 0.8,
				Display = 4,
				Color = 68,
				Pos = { x = 1764.65, y = 3342.33, z = 45.00 },
			},
			SandyShoresImpound = {
				Zone = "Impound",
				Sprite = 67,
				Scale = 0.8,
				Display = 4,
				Color = 47,
				Pos = { x = 1736.71, y = 3689.35, z = 35.90 },
			},
			CityHallGarage = {
				Zone = "Garage",
				Sprite = 50,
				Scale = 0.8,
				Display = 4,
				Color = 68,
				Pos = { x = 270.97, y = -343.23, z = 44.51 },
			},
		},

		Markers = {
			CityGarage = {
				Zone = "Garage",
				Type = 1,
				Heading = 160.00,
				Scale = { x = 3.0, y = 3.0, z = 1.0 },
				Color = { r = 43, g = 187, b = 255 },
				Pos = { x = 228.75, y = -747.37, z = 29.70 },
			},			
			VehicleStoreGarage = {
				Zone = "Garage",
				Type = 1,
				Heading = 90.00,
				Scale = { x = 3.0, y = 3.0, z = 1.0 },
				Color = { r = 43, g = 187, b = 255 },
				Pos = { x = -66.54, y = -1165.96, z = 25.00 },
			},
			CityImpound = {
				Zone = "Impound",
				Type = 1,
				Heading = 300.00,
				Scale = { x = 3.0, y = 3.0, z = 1.0 },
				Color = { r = 255, g = 165, b = 0 },
				Pos = { x = 480.60, y = -1317.64, z = 28.25 },
			},
			PaletoGarage = {
				Zone = "Garage",
				Type = 1,
				Heading = 160.00,
				Scale = { x = 3.0, y = 3.0, z = 1.0 },
				Color = { r = 43, g = 187, b = 255 },
				Pos = { x = 128.78, y = 6622.99, z = 30.77 },
			},			
			PaletoImpound = {
				Zone = "Impound",
				Type = 1,
				Heading = 310.00,
				Scale = { x = 3.0, y = 3.0, z = 1.0 },
				Color = { r = 255, g = 165, b = 0 },
				Pos = { x = -471.30, y = 6018.74, z = 30.30 },
			},
			MedicalTowerGarage = {
				Zone = "Garage",
				Type = 1,
				Heading = 175.00,
				Scale = { x = 3.0, y = 3.0, z = 1.0 },
				Color = { r = 43, g = 187, b = 255 },
				Pos = { x = -654.77, y = 310.27, z = 81.97 },
			},	
			SandyShoresGarage = {
				Zone = "Garage",
				Type = 1,
				Heading = 120.00,
				Scale = { x = 3.0, y = 3.0, z = 1.0 },
				Color = { r = 43, g = 187, b = 255 },
				Pos = { x = 1764.65, y = 3342.33, z = 40.00 },
			},
			SandyShoresImpound = {
				Zone = "Impound",
				Type = 1,
				Heading = 300.00,
				Scale = { x = 3.0, y = 3.0, z = 1.0 },
				Color = { r = 255, g = 165, b = 0 },
				Pos = { x = 1736.71, y = 3689.35, z = 33.31 },
			},
			CityHallGarage = {
				Zone = "Garage",
				Type = 1,
				Heading = 300.00,
				Scale = { x = 3.0, y = 3.0, z = 1.0 },
				Color = { r = 43, g = 187, b = 255 },
				Pos = { x = 270.97, y = -343.23, z = 44.51 },
			},
			
				NorthConkerevnueFinnick = {
				Zone = "Garage",
                Type = 20,
                Heading = 281.37,
                Scale = { x = .25, y = .25, z = .25 },
                Color = { r = 43, g = 187, b = 255 },
                Pos = { x = 391.26, y = 430.49, z = 143.6 },
            },
			
				NorthConkerevnueJon = {
				Zone = "Garage",
                Type = 20,
                Heading = 281.37,
                Scale = { x = .25, y = .25, z = .25 },
                Color = { r = 43, g = 187, b = 255 },
                Pos = { x = 352.54, y = 437.03, z = 147.09 },
            },
			
				RichardApt = {
				Zone = "Garage",
                Type = 20,
                Heading = 26.2,
                Scale = { x = .25, y = .25, z = .25 },
                Color = { r = 43, g = 187, b = 255 },
                Pos = { x = -960.42, y = -307.34, z = 37.92 },
            },
				PoliceGarage = {
				Zone = "Garage",
				Type = 1,
				Heading = 300.00,
				Scale = { x = 3.0, y = 3.0, z = 1.0 },
				Color = { r = 43, g = 187, b = 255 },
				Pos = { x = 452.37, y = -997.84, z = 24.94 },
			},
			
			
			
			
			
			
			
			
			
			
			
		},

		Keys = {
		    ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57, 
		    ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177, 
		    ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
		    ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
		    ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
		    ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70, 
		    ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
		    ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
		    ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
		},
	}
}

Config                      = {}
Config.Locale = 'en'
Config.EnableDebug          = false
