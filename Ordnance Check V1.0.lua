--Ordnance Check Script V1.0 by GTFreeFlyer.
--Copyright 2019.
--This script is free to use in any non-revenue gererating server or for any non-revenue generating purpose.  
--Use of this script in any server that accepts money for membership, donations, etc, is not permitted.  Contact GTFreeFlyer@yahoo.com for permission to use in a revenue generating server.
--Modification of the script is not allowed without mentioning credit where it came from.  Contact GTFreeFlyer if you would like to modify this script beyond Section 1 below.
--Thanks for your understanding and cooperation.

env.info("GTFreeFlyer's Ordnance Check Script: Started")  -- This is just a debug line that will appear in your DCS log file.

--SECTION 1: INITIAL SETUP (REQUIRED). 
--These are the aircraft names on which you would like run the ordnance check.  They should match the PILOT name (not the group name) of the aircraft in the Mission Editor.
-- You can change the names here, or in the Mission Editor.  It doesn't matter where the name is changed as long as they match.  You can add or remove from this list as desired.
_aircraft = {                                   
    "Aircraft #001",
    "Aircraft #002",
    "Aircraft #003",
    "Aircraft #004"  -- the last entry does not need a comma after it
} 

--SECTION 2: ADDITIONAL OPTIONS (NOT REQUIRED TO EDIT)
local _checkInterval = 30 -- this is the time, in seconds, of how often you want the script to check all aircraft for ordnance.  Shorter times use more computer bandwidth, while shorter times may allow an aircraft to get airborne and travel far before getting blown up.
local _checkAltitude = 500 -- Altitude (MSL) in feet above which ordnance check will be valid.  For example if set to 500, aircraft with ordnance will not blow up until they reach an altitude of 500 feet.  Be careful and make sure this is higher than the airfield's elevation, otherwise the aircraft will explode as soon as it rearms on the ground.
local _explosionSize = 100 -- this is the size/strength of the explosion (1 to 100) that will blow up the aircraft.  Leave at 100 unless it seems to be hurting other nearby wingmen who may have taken off in formation

env.info("GTFreeFlyer's Ordnance Check Script: Interval set to " .. _checkInterval .. " seconds.  Altitude set to " .. _checkAltitude .. " feet.  Explosion size set to " .. _explosionSize) -- This is just a debug line that will appear in your DCS log file.
------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
--SECTION 3: SCRIPT FUNCTIONS.  DO NOT EDIT BELOW THIS LINE

function ordnanceCheckLoop()
    timer.scheduleFunction(ordnanceCheckLoop, nil, timer.getTime() + _checkInterval) -- runs this loop every _checkInterval seconds
    for _i = 1, #_aircraft do
        local _name = Unit.getByName(_aircraft[_i]) -- Unit.getByName returns a class, not a string, so this line essentially converts the string from Section 1 into a class, which is required for the getAmmo() function below
        if _name ~= nil then -- If the aircraft is unoccupied, _name will be nil, code below will be skipped, and the next aircraft in the list will be checked.
            if _name:getAmmo() ~= nil then -- if getAmmo() is not nil then it means you have ordnance on your aircraft and the lines below will execute!
                local _aircraftLocation = {} -- Sets/Resets _aircraftLocation to a blank list of entires
                _aircraftLocation = _name:getPoint() -- this will set the x,y,z location of the aircraft
                local _aircraftAltitude = _aircraftLocation.y * 3.28084  -- _aircraftLocation.y is returned in meters, converted here to feet
                if _aircraftAltitude > _checkAltitude then
                    trigger.action.explosion(_aircraftLocation, _explosionSize) -- this is the line of code that will create an explosion at the same location as the aircraft
                    local _groupName = _name:getGroup() -- now we find the group name of the aircraft in order to run the next line of code
                    trigger.action.outTextForGroup(_groupName:getID(), "Nice try " .. _name:getPlayerName() .. "! You can't carry weapons in this mission.", 15, true) -- Displays a message to the pilot and any other aircraft in the same group about why he was just blown out of the sky.
                    env.info(_name:getPlayerName() .. " tried to take off with ordnance and has been blown to pieces.")  -- This is just a debug line that will appear in your DCS log file.
                end
            end
        end
    end 
end 

timer.scheduleFunction(ordnanceCheckLoop, nil, timer.getTime() + 1) -- this line will initiate the function above once the script is loaded

