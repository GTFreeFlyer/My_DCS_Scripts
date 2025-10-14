-- ExplodeWeakAircraft_v7.lua 8/3/2025
-- By, GTFreeFlyer.  You may reach out to me on Discord or ED Forums, same username, for support, questions, or suggestions.
-- Assisted by Foxtrot and LoVis with Virtual Carrier Task Force 58
-- DCS World script: Causes weak enemy units to explode once reaching a certain health threshold.
-- Use of this script is permitted for any purpose, commercial or non-commercial.  Have fun with it and share what you've created :)
-- I always appreciate when authors are acknowledged. Please include in your briefing, "ExplodeWeakAircraft script by GTFreeFlyer".

--CHANGE LOG:
--v7 Oct. 14, 2025.
--  - Added ability to configure mulitiple explosions per unit until destroyed. Looks great on ships as secondary explosions, but might be a little cheesy on aircraft continually exploding until they hit the ground.  Your choice via USER SETTINGS.
--  - Removed ships category after finding out they are all categorized as ground units in DCS.
--  - Added more ship types to the prepopulated list.
--  - "all" category for unit not working - FIXED!

--Instructions:
-- 1. Update the USER SETTINGS below per your liking.
-- 2. Load this script in the mission editor via trigger action "DO SCRIPT FILE".

------- USER SETTINGS------------------------------------------------------------------

--More instructions:
--Add desired unit types below. 
--unitTypeName must match the DCS type names exactly. Some are prepopulated below, but to get others, turn on debugMode below, run the mission, and check the dcs.log file for unit type names detected. Case sensitive!
--You can do this for any unit in game (airplane, helicopter, ship, and/or ground unit.  Please note that all ships are categorized as ground units in DCS).
--Whichever unit types you want to emit, just place a "-- before the line to comment it out of the script.  Don't delete the line so that way you can build a list of all the units eventually.

--healthTtrigger is a range from .06 to 1, where 1 is full health and .06 is 6% health.  Do not set to 1, as that would trigger explosions from the very start of the mission.  Do not set below 6% as 5% is the current low end.
--explosionPower is a number that determines the explosion size.  Increase it for larger explosions, but be careful not to make it too high or you may take damage if you are close to the explosion.
--launchFlares is for visual effect simulating sparks or secondaries from the explosion.  Set to true if you want to see flares launched at the unit's location when it explodes.
--explosionsContinueUntilDestroyed will determine if explosions and flares continue every one second until the unit is gone (aircraft hits ground, or ship sinks, etc.).  If false, you'll see just one explosion.

local debugMode = false -- Set to true if you want to see debug messages in the DCS log file.  Set to false to disable debug messages.  This is how you can find the correct unit names for below.

local unitTypesToExplode = {
    --WARBIRDS
    {unitTypeName = "FW-190A8",           healthTrigger = 0.5, explosionPower = 50, launchFlares = true, explosionsContinueUntilDestroyed = false}, 
    {unitTypeName = "FW-190D9",           healthTrigger = 0.5, explosionPower = 50, launchFlares = true, explosionsContinueUntilDestroyed = false},
    {unitTypeName = "I-16",               healthTrigger = 0.5, explosionPower = 50, launchFlares = true, explosionsContinueUntilDestroyed = false},  
    {unitTypeName = "Bf-109k-4",          healthTrigger = 0.5, explosionPower = 50, launchFlares = true, explosionsContinueUntilDestroyed = false}, 
    --{unitTypeName = "SpitfireLFMkIXCW", healthTrigger = 0.5, explosionPower = 50, launchFlares = true, explosionsContinueUntilDestroyed = false}, 
    --{unitTypeName = "F4U-1D",           healthTrigger = 0.5, explosionPower = 50, launchFlares = true, explosionsContinueUntilDestroyed = false}, 
    --{unitTypeName = "B-17G",            healthTrigger = 0.5, explosionPower = 50, launchFlares = true, explosionsContinueUntilDestroyed = false}, 

    --JETS
    --{unitTypeName = "FA-18C_hornet",    healthTrigger = 0.5, explosionPower = 50, launchFlares = true, explosionsContinueUntilDestroyed = false}, 

    --GROUND UNITS
    --{unitTypeName = "T-55",             healthTrigger = 0.5, explosionPower = 500, launchFlares = true, explosionsContinueUntilDestroyed = false}, 
    --{unitTypeName = "T-72B",            healthTrigger = 0.5, explosionPower = 500, launchFlares = true, explosionsContinueUntilDestroyed = false}, 

    --SHIPS (NOTE: ALL SHIPS ARE CATEGORIZED AS GROUND UNITS IN DCS)
    {unitTypeName = "MOSCOW",                  healthTrigger = 0.7, explosionPower = 1000, launchFlares = true, explosionsContinueUntilDestroyed = true}, --Cruiser 1164 Moskva
    --{unitTypeName = "Essex",                 healthTrigger = 0.5, explosionPower = 500, launchFlares = true, explosionsContinueUntilDestroyed = true}, 
    --{unitTypeName = "Stennis",               healthTrigger = 0.5, explosionPower = 500, launchFlares = true, explosionsContinueUntilDestroyed = true},  
    --{unitTypeName = "ijn_nagara",            healthTrigger = 0.5, explosionPower = 500, launchFlares = true, explosionsContinueUntilDestroyed = true}, 
    --{unitTypeName = "ijn_nagato",            healthTrigger = 0.5, explosionPower = 500, launchFlares = true, explosionsContinueUntilDestroyed = true}, 
    --{unitTypeName = "Dry-cargo ship-1",      healthTrigger = 0.5, explosionPower = 500, launchFlares = true, explosionsContinueUntilDestroyed = true}, 
    --{unitTypeName = "Dry-cargo ship-2",      healthTrigger = 0.5, explosionPower = 500, launchFlares = true, explosionsContinueUntilDestroyed = true}, 
    --{unitTypeName = "HandyWind",             healthTrigger = 0.5, explosionPower = 500, launchFlares = true, explosionsContinueUntilDestroyed = true}, --Bulker Handy Wind
    --{unitTypeName = "USS_Samuel_Chase",      healthTrigger = 0.5, explosionPower = 500, launchFlares = true, explosionsContinueUntilDestroyed = true},   
    --{unitTypeName = "TICONDEROG",            healthTrigger = 0.5, explosionPower = 500, launchFlares = true, explosionsContinueUntilDestroyed = true}, 
    --{unitTypeName = "santafe",               healthTrigger = 0.5, explosionPower = 500, launchFlares = true, explosionsContinueUntilDestroyed = true},  
    --{unitTypeName = "Higgins_boat",          healthTrigger = 0.5, explosionPower = 500, launchFlares = true, explosionsContinueUntilDestroyed = true},  
    --{unitTypeName = "Schnellboot_type_S130", healthTrigger = 0.5, explosionPower = 500, launchFlares = true, explosionsContinueUntilDestroyed = true}, --Boat Schnellboot S130
    --{unitTypeName = "ijn_oiler_kamoi",       healthTrigger = 0.5, explosionPower = 500, launchFlares = true, explosionsContinueUntilDestroyed = true}, --IJN Oiler Kamoi
    --{unitTypeName = "kentucky",              healthTrigger = 0.5, explosionPower = 500, launchFlares = true, explosionsContinueUntilDestroyed = true}, --USS Kentucky BB-66
    --{unitTypeName = "new_jersey_empty",      healthTrigger = 0.5, explosionPower = 500, launchFlares = true, explosionsContinueUntilDestroyed = true}, --USS New Jersey W/O Aircraft
    --{unitTypeName = "PERRY",                 healthTrigger = 0.5, explosionPower = 500, launchFlares = true, explosionsContinueUntilDestroyed = true}, --FFG Oliver Hazard Perry
    --{unitTypeName = "missouri",              healthTrigger = 0.5, explosionPower = 500, launchFlares = true, explosionsContinueUntilDestroyed = true}, --USS Missouri
    --{unitTypeName = "CVN_73",                healthTrigger = 0.5, explosionPower = 500, launchFlares = true, explosionsContinueUntilDestroyed = true}, --CVN-73 George Washington
    --{unitTypeName = "Forrestal",             healthTrigger = 0.5, explosionPower = 500, launchFlares = true, explosionsContinueUntilDestroyed = true}, --CV-59 Forrestal
    --{unitTypeName = "Ship_Tilde_Supply",     healthTrigger = 0.5, explosionPower = 500, launchFlares = true, explosionsContinueUntilDestroyed = true}, --Supply Ship MV Tilde
    --{unitTypeName = "HarborTug",             healthTrigger = 0.5, explosionPower = 500, launchFlares = true, explosionsContinueUntilDestroyed = true}, --Harbor Tug
    --{unitTypeName = "uss_radford",           healthTrigger = 0.5, explosionPower = 500, launchFlares = true, explosionsContinueUntilDestroyed = true}, --USS Radford DD-446
    --{unitTypeName = "KILO",                  healthTrigger = 0.5, explosionPower = 500, launchFlares = true, explosionsContinueUntilDestroyed = true}, --SSK 877V Kilo

}
    -- Additional options are below to cover entire categories, so you don't have to list out every ship, if you want it to apply to all ships, for example.
    -- If you want to use them, uncomment the lines below by removing the "--" at the beginning of the line. Make sure to leave the braces {} and commas in place.
    -- Priority is handled from top to bottom, so leave the individual unit types above this line, and the blanket category types below.
    -- If, for example, you enable the line with allAIRPLANE, then there's no need to specify any specfic airplanes above.
 
local unitCategoriesToExplode = {
    {unitTypeName = "allAirplane",   healthTrigger = 0.5, explosionPower = 50, launchFlares = true, explosionsContinueUntilDestroyed = false},    -- Uncomment this line to apply to all other airplanes types not specifed above.
    {unitTypeName = "allHelicopter", healthTrigger = 0.5, explosionPower = 50, launchFlares = true, explosionsContinueUntilDestroyed = false},  -- Uncomment this line to apply to all other helicopter types not specifed above
    {unitTypeName = "allGround",     healthTrigger = 0.5, explosionPower = 500, launchFlares = true, explosionsContinueUntilDestroyed = true},  -- Uncomment this line to apply to all other ground unit types not specifed above.
}



------ Do not change the code below this line------------------------------------------------
local _coalitions = {coalition.side.BLUE, coalition.side.RED, coalition.side.NEUTRAL}
local _groupCategories = {Group.Category.AIRPLANE, Group.Category.HELICOPTER, Group.Category.SHIP, Group.Category.GROUND}
trigger.action.outText("GTFreeFlyer's ExplodeWeakUnits_v7 script loaded successfully.", 5)
env.info("GTFreeFlyer's ExplodeWeakUnits_v7 script loaded successfully.")

local function explodeUnit(_unit, _typeName, _healthTrigger, _explosionPower, _flares, _multipleExplosions)
    local health = _unit:getLife() / _unit:getLife0()  -- Check current health divided by initial health
    local _unitsName = _unit:getName() -- Get name of unit.
	if health <= _healthTrigger and trigger.misc.getUserFlag(_unitsName .."_Exploded") ~= 1 then -- If health is below the threshold from the USER SETTINGS, and unit has not yet had an explosion, trigger explosion on the unit
        if _flares then
            local _unitLocation = _unit:getPoint() -- Get the unit's location
            trigger.action.signalFlare(_unitLocation, trigger.flareColor.Red, 0) -- Launch flares at the unit's location, last digit is the heading for flare launch   
            trigger.action.signalFlare(_unitLocation, trigger.flareColor.White, 60)
            trigger.action.signalFlare(_unitLocation, trigger.flareColor.Red, 120)
            trigger.action.signalFlare(_unitLocation, trigger.flareColor.White, 180)
            trigger.action.signalFlare(_unitLocation, trigger.flareColor.Red, 240)
            trigger.action.signalFlare(_unitLocation, trigger.flareColor.White, 300) 
        end
        trigger.action.explosion(_unit:getPoint(), _explosionPower)
        if _multipleExplosions == false then
            trigger.action.setUserFlag(_unitsName .. "_Exploded", 1) -- Set a user flag to indicate the unit has exploded so that it does not continue exploding every second
            if debugMode then
                env.info("Flag set to stop further explosions for unit: " .. _unitsName)
            end
        end                        
        env.info("GTFreeFlyer's ExplodeWeakAircraft script has triggered an event: ".. _unitsName .. " - " .. _typeName .. " exploded at health " .. health .. " with explosion power " .. _explosionPower)
        if debugMode then
            trigger.action.outText("GTFreeFlyer's ExplodeWeakAircraft script has triggered an event: ".. _unitsName .. " - " .. _typeName .. " exploded at health " .. health .. " with explosion power " .. _explosionPower, 10)
        end
    end
end

local function checkUnits()
    timer.scheduleFunction(checkUnits, nil, timer.getTime() + 1) -- schedule this function to run again in 1 second 
    for _, _coalition in ipairs(_coalitions) do
        for _, _groupCategory in ipairs(_groupCategories) do
            local _groups = coalition.getGroups(_coalition, _groupCategory) -- Get the list of all GROUPS
            if _groups then -- Check if _groups is not nil
                for _, group in ipairs(_groups) do
                    local _units = group:getUnits() -- Get the list of all UNITS within each of the groups
                    if _units then -- Check if _units is not nil
                        for _, _unit in ipairs(_units) do
                            local typeName = _unit:getTypeName()
                            for _, allowedType in ipairs(unitTypesToExplode) do -- Check if the aircraft type is in the list from the USER SETTINGS
                                if typeName == allowedType.unitTypeName then
                                    shouldExplode = true
                                    if _unit:isActive() then explodeUnit(_unit, typeName, allowedType.healthTrigger, allowedType.explosionPower, allowedType.launchFlares, allowedType.explosionsContinueUntilDestroyed) end
                                    break
                                end
                            end
                            if not shouldExplode then
                                if _groupCategory == 0 then _groupCategoryName = "Airplane" end
                                if _groupCategory == 1 then _groupCategoryName = "Helicopter" end   
                                if _groupCategory == 2 then _groupCategoryName = "Ship" end
                                if _groupCategory == 3 then _groupCategoryName = "Ground" end 
                                typeName = "all" .. _groupCategoryName -- If not found in the specific unit types, check against the category types                    
                                for _, allowedType in ipairs(unitCategoriesToExplode) do -- Check if the aircraft type is in the list from the USER SETTINGS
                                    if typeName == allowedType.unitTypeName then
                                        shouldExplode = true
                                        if _unit:isActive() then explodeUnit(_unit, typeName, allowedType.healthTrigger, allowedType.explosionPower, allowedType.launchFlares, allowedType.explosionsContinueUntilDestroyed) end
                                        shouldExplode = false -- Reset for the next unit
                                        break
                                    end
                                end
                            else
                                shouldExplode = false -- Reset for the next unit
                            end                           
                        end
                    end
                end
            end
        end
    end
end

local function debugGetUnitNamesInMission()
    trigger.action.outText("GTFreeFlyer's ExplodeWeakAircraft script is running in debug mode.  It will list all unit names in the mission in the dcs.log file.", 10)
    for _, _coalition in ipairs(_coalitions) do
        for _, _groupCategory in ipairs(_groupCategories) do
            local _groups = coalition.getGroups(_coalition, _groupCategory) -- Get the list of all airplane GROUPS
            if _groups then -- Check if _groups is not nil
                for _, group in ipairs(_groups) do
                    local _units = group:getUnits() -- Get the list of all UNITS within each of the groups
                    if _units then -- Check if _units is not nil
                        for _, _unit in ipairs(_units) do
                            local typeName = _unit:getTypeName()
                            local _unitsName = _unit:getName() -- Get name of unit
                            if _groupCategory == 0 then _groupCategory = "Airplane" end
                            if _groupCategory == 1 then _groupCategory = "Helicopter" end   
                            if _groupCategory == 2 then _groupCategory = "Ship" end
                            if _groupCategory == 3 then _groupCategory = "Ground" end                            
                            env.info("GTFreeFlyer's ExplodeWeakAircraft script has detected unit: " .. _unitsName .. ". Category: ".. _groupCategory .. ". Type: " .. typeName)
                        end
                    end
                end
            end
        end
    end
end

checkUnits() -- Kicks off the script, then the scheduleFunction() inside the function will keep it running every second.
if debugMode then
    debugGetUnitNamesInMission()
end
