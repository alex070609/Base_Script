Config = {}

Config.Locale = "en"

Config.DrawDistance = 10.0
Config.MarkerSize   = {x = 1.0, y = 1.0, z = 0.1}
Config.MarkerColor  = {r = 255, g = 255, b = 255}
Config.MarkerType   = 1


Config.Job = "jobhere" -- set nil to not be locked by a job // "job" for locked for a specified job // {['job'] = 2} for a specific grade in a job You can even set {['job1'] = 3, ['job2'] = 4} for mutiple jobs and grades
Config.Name = GetCurrentResourceName()
Config.Crafting = true -- defines if crafting is enabled or not (true/false)
Config.CraftingPos = vector3(0.0, 0.0, 0.0) -- defines where the crafting menu is located

-- Defines the zones for specific action/menus
Config.Zones = {
    {
        Pos   = vector3(0.0,0.0,0.0), -- defines where the boss menu is
        Name  = "boss", -- /!\ DO NOT TOUCH /!\
    },
    {
        Pos   = vector3(0.0,0.0,0.0), -- defines where a zone is located /!\ STASHES ARE DEFINED IN CONFIG.STASHES /!\
        Name  = "cloakroom", -- used to decide wich zone to open in main.lua
    }
}

-- Defines the stashes
Config.Stashes = {
    {
        Pos = vector3(0.0,0.0,0.0), -- Defines the placement of the stashe
        name = "stashe_"..Config.Name, -- DO NOT TOUCH
        label = "Coffre", -- define the name of the stashe when opening the menu
        slots = 20, -- define number of slots available (diffrent items)
        weight = 100000, -- in grams (100 000 = 100 Kg)
        specific = nil, -- set to true for one per users (by identifier) // set nil for a shared stashe // "char1:licence" for a specific person
        job = Config.Job, -- see config.job
        enabled = true -- used to defined if stashe is enabled or disabled
    },
    {
        Pos = vector3(0.0,0.0,0.0),
        name = "stashe_"..Config.Name.."_personnal", -- DO NOT TOUCH
        label = "Coffre personnel",
        slots = 20,
        weight = 100000,
        specific = true, -- user specific
        job = nil, -- public
        enabled = true
    },
    {
        Pos = vector3(0.0,0.0,0.0),
        name = "stashe_"..Config.Name.."_freezer", -- DO NOT TOUCH
        label = "Frigo",
        slots = 20,
        weight = 100000,
        specific = nil, -- shared
        job = Config.Job, -- for specified job
        enabled = true
    }
}

-- Defines the craftables items
Config.Craft = {
    {
        Item = "nomitem", -- define item name to be crafted (ox_inventory)
        Label = "Label d'item", -- define the name for menus
        Fabrication = { -- here define the items needed for the crafting of item
            {value = 'nomitem', label = "Label Item", remove = true}, -- value needs to be the name in ox_inventory items // label is for notification if user don't have item 
                                                                    -- // remove is if the item needs to be removed from inventory
            {value = 'nomitem', label = "Label Item", remove = true}
        },
    }
}

-- Defines the work clothes
Config.Clothes = {
    male = {
        ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
        ['torso_1'] = 241,   ['torso_2'] = 1,
        ['arms'] = 0,
        ['pants_1'] = 130,   ['pants_2'] = 0,
        ['shoes_1'] = 25,   ['shoes_2'] = 0,
		['chain_1'] = 0, 	['chain_2'] = 0
    },
    female = {
        ['tshirt_1'] = 14,  ['tshirt_2'] = 0,
        ['torso_1'] = 249,   ['torso_2'] = 1,
        ['arms'] = 0,
        ['pants_1'] = 136,   ['pants_2'] = 0,
        ['shoes_1'] = 25,   ['shoes_2'] = 0,
		['chain_1'] = 0, 	['chain_2'] = 0
    }
}