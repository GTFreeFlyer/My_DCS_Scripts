--GTFreeFlyer's Carrier Map Position Plotter Script for DCS World, created April 2026

--ABOUT THIS SCRIPT:
--Loads at mission start, finds all carriers, and then puts markers on the F10 map of where the carriers are expected
--to be every X hours, based on their current speed and course.  Does not work for carriers that turn mid-mission.
--Markers are only visible to the same coalition as the carriers.

--INSTRUCTIONS:
--Requires MIST (Mission Scripting Tools). You can download MIST for free from https://github.com/mrSkortch/MissionScriptingTools
--Adjust the user options below to your liking.
--MIST script must be loaded first.  You don't touch this script.  Just load it into your .miz via trigger action DO SCRIPT FILE.
--Load this script in once your carriers are underway and up to their cruising speed. (For example, use trigger condition TIME MORE than 60 seconds, or so)

--YOUR GO-TO RESOURCE FOR ANY QUESTIONS OR TROUBLESHOOTING:
--For support and discussion, please visit GT's Runway (Discord).  Find GTFreeFlyer on Discord and the link is in my profile.  (You can find me in the DCS Discord members list)

--COPYRIGHT AND TERMS OF USE:
--All rights reserved. Copyright 2026 by GTFreeFlyer.
--This script is free to use and distribute for non-commercial use.  Lots of hard work went into this, so please give credit where credit is due if you use this script.
--It's as simple as dropping a line in your mission briefing, like "Carrier Map Position Plotter script by GTFreeFlyer" or something like that.  Thanks, and enjoy, AND SHARE the script!
--No part of this script may be reproduced, distributed, or transmitted in any form or by any means, including but not limited to copying, recording, 
--or other electronic or mechanical methods, for commercial use, without the prior written permission of the author, GTFreeFlyer.

--CONTACT INFO:
--GTFreeFlyer@yahoo.com, or GTFreeFlyer on Discord and the ED Forums.
---------------------------------------------------------------------------------------------------------------------------------------------------
env.info("Loading GTFreeFlyer's Carrier Map Position Plotter v1.0...")
---------------------------------------------------------------------------------------------------------------------------------------------------
--USER OPTIONS (EDIT THESE TO YOUR LIKING)---------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------
MarkerSpacingInHours = 2 --How far apart (in hours) do you want the markers to be?
NumberOfMarkersToPlot = 7 --How many markers do you want to plot?  For example, if MarkerSpacingInHours is 1 and NumberOfMarkersToPlot is 3, then the script will plot markers for where the carrier is now, expected to be in 1 hour, and 2 hours.
TypeNamesOfCarriersToInclude = {"CVN_71", "CVN_72", "CVN_73", "CVN_74", "CVN_75", 
                                "Essex", "Forrestal", "CV_1143_5", "KUZNECOW", 
                                "ara_vdm", "Stennis", "hms_invincible", "LHA_Tarawa",
                                "atconveyor"} --Recommend to include all types DCS has to offer so that they will automatically plot if they exist, and exclude specific units in the next line. You can get the exact names by setting CarrierDebugMode to true.
UnitNamesOfCarriersToExclude = {"HBR"} --Use the unit name (not group name) as defined in the Mission Editor. You can get the exact names by setting CarrierDebugMode to true.
CarrierDebugMode = false --Set to true to enable debug messages in the DCS log file about which units were found, and what the script is doing. Set to false to disable those messages.
---------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------
--DEFINITIONS (DO NOT EDIT BELOW THIS LINE)--------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------

--Local variables, hardcoded, not meant to be edited by the user through the mission editor

--Placeholders for data that will be collected. Do not edit.
local blueCarriers = {coalition = coalition.side.BLUE} --contains the unit objects of all blue carriers
local redCarriers = {coalition = coalition.side.RED} --contains the unit objects of all red carriers
local neutralCarriers = {coalition = coalition.side.NEUTRAL} --contains the unit objects of all neutral carriers (not used in this script, but could be used in a future update)
local markerIndexNumber = 10000 --used to create unique marker ID numbers, starting at 10,000 to avoid conflicts with other scripts that may use lower numbers for markers

---------------------------------------------------------------------------------------------------------------------------------------------------
--MAIN SCRIPT--------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------
local function findTheCarriers()
--Find all ships and assign to the correct coalition

    if CarrierDebugMode then env.info("Finding carriers...") end

    --define volume to search (the whole map)
    local vol = {
        id = world.VolumeType.SPHERE,
        params = {
            point = { x = 0, y = 0, z = 0 },
            radius = 2000000 -- 2,000 km, covers all maps
        }
    }

    world.searchObjects(
        Object.Category.UNIT, vol,
        function(unit)
   --First, go through the list of all units detected in the mission
            for _, typeName in ipairs(TypeNamesOfCarriersToInclude) do
    --Next, check if the unit is a carrier type that we want to include
                if CarrierDebugMode then env.info("Checking unit name: " .. unit:getName() .. " of type: " .. unit:getTypeName()) end
                if unit:getTypeName() == typeName then
                    if CarrierDebugMode then env.info("This one is a type that we want to investigate further to see if it should be excluded...") end
    --Then, check if the unit is on the exclusion list, and if so, skip it and don't add to any list
                    local exclude = false
                    for _, unitName in ipairs(UnitNamesOfCarriersToExclude) do
                        if unit:getName() == unitName then
                            exclude = true
                            if CarrierDebugMode then env.info("Found: " .. unit:getName() .. " in the exclusion list, so it will not be added to any list") end
                            break
                        end
                    end
                    if CarrierDebugMode then env.info("Exclusion checks complete") end
    --Finally, if the unit is a carrier type we want to include and it's not on the exclusion list, add it to the correct coalition's list                
                    if not exclude then
                        if unit:getCoalition() == coalition.side.BLUE then
                            table.insert(blueCarriers, unit)
                            if CarrierDebugMode then env.info("Found carrier: " .. unit:getName() .. " and added to blue coaltion's list") end
                        elseif unit:getCoalition() == coalition.side.RED then
                            table.insert(redCarriers, unit)
                            if CarrierDebugMode then env.info("Found carrier: " .. unit:getName() .. " and added to red coaltion's list") end
                        else
                            table.insert(neutralCarriers, unit)
                            if CarrierDebugMode then env.info("Found carrier: " .. unit:getName() .. " and added to neutral coaltion's list") end
                        end
                    end
                end
            end
            return true
        end
    )
end
------------------------------------------------------------------------------------------------------------------------------------------------
--convert radians to degrees and normalize to 0-360
local function radToDeg(radians)
    return (radians * 180 / math.pi + 360) % 360
end
------------------------------------------------------------------------------------------------------------------------------------------------
--format time in seconds to HH:MM format
local function formatTime(seconds)
    local hours = math.floor(seconds / 3600)
    local minutes = math.floor((seconds % 3600) / 60)
    local formattedTime = string.format("%02d:%02d", hours, minutes)
    if CarrierDebugMode then env.info("Formatted time: " .. formattedTime) end
    return formattedTime
end
------------------------------------------------------------------------------------------------------------------------------------------------
--get mission clock time as displayed in the F10 map, or on a cockpit clock, in seconds past midnight 
local function getMissionTime()
    local missionTime = (timer.getTime() + timer.getTime0()) % 86400
    if CarrierDebugMode then env.info("Current mission time in seconds past midnight: " .. missionTime) end
    return missionTime
end
------------------------------------------------------------------------------------------------------------------------------------------------
--Get the carrier's current position, speed, and true course (normalized to 0-360 degrees)
local function getCarrierCurrentData(carrierObj)
    if CarrierDebugMode then env.info("Getting current data for carrier: " .. carrierObj:getName()) end
    local position = carrierObj:getPoint()
    if CarrierDebugMode then env.info("Current position of " .. carrierObj:getName() .. ": x=" .. position.x .. ", y=" .. position.y .. ", z=" .. position.z) end
    local velocityVector = carrierObj:getVelocity()
    if CarrierDebugMode then env.info("Current velocity vector of " .. carrierObj:getName() .. ": x=" .. velocityVector.x .. ", y=" .. velocityVector.y .. ", z=" .. velocityVector.z) end
    local speed = math.sqrt(velocityVector.x^2 + velocityVector.y^2 + velocityVector.z^2) --m/s
    if CarrierDebugMode then env.info("Current speed of " .. carrierObj:getName() .. ": " .. speed .. " m/s") end
    local magneticCourse = radToDeg(mist.getHeading(carrierObj))
    if CarrierDebugMode then env.info("Current magnetic course of " .. carrierObj:getName() .. ": " .. magneticCourse .. " degrees") end
    local trueCourse = (magneticCourse - radToDeg(mist.getNorthCorrection(position))) % 360
    if CarrierDebugMode then env.info("Current true course of " .. carrierObj:getName() .. ": " .. trueCourse .. " degrees") end
    return position, speed, trueCourse
end
------------------------------------------------------------------------------------------------------------------------------------------------
--Project the carrier's future position based on its current speed and course, and plot a marker on the F10 map at that location
local function plotFuturePositions(carriers)
    if CarrierDebugMode then env.info("Plotting future positions...") end
    for _, carrierObj in ipairs(carriers) do
        if CarrierDebugMode then env.info("Calculating future positions for carrier: " .. carrierObj:getName()) end
        local position, speed, trueCourse = getCarrierCurrentData(carrierObj)
        for i = 0, NumberOfMarkersToPlot - 1 do
            local hoursInFuture = i * MarkerSpacingInHours
            local distance = speed * hoursInFuture * 3600 -- distance = speed * time (convert hours to seconds)
            local futureX = position.x + (distance * math.cos(math.rad(trueCourse)))
            local futureZ = position.z + (distance * math.sin(math.rad(trueCourse)))
            local futurePosition = { x = futureX, y = 0, z = futureZ }
            if CarrierDebugMode then env.info(string.format("Future position for %s in %d hours will be: x=%.2f, z=%.2f", carrierObj:getName(), hoursInFuture, futureX, futureZ)) end
            local futureTime = (getMissionTime() + hoursInFuture * 3600) % 86400 --seconds after midnight
            if CarrierDebugMode then env.info("Future time for " .. carrierObj:getName() .. " in " .. hoursInFuture .. " hours will be: " .. futureTime .. " seconds past midnight") end
            futureTime = formatTime(futureTime) --HH:MM format
            if CarrierDebugMode then env.info("Formatted future time for marker label: " .. futureTime) end
            local markerText = string.format("%s: %s", carrierObj:getName(), futureTime)
            local usersCannotRemoveMark = true
            trigger.action.markToCoalition(markerIndexNumber, markerText, futurePosition, carriers.coalition, usersCannotRemoveMark)
            if CarrierDebugMode then env.info("Plotted future position for " .. carrierObj:getName() .. " at " .. futureTime .. " on the F10 map, with ID " .. markerIndexNumber) end
            markerIndexNumber = markerIndexNumber + 1 --increment marker ID number for the next marker to ensure uniqueness
        end
    end
end
------------------------------------------------------------------------------------------------------------------------------------------------
--list out all the user settings in the DCS log file for easy reference
if CarrierDebugMode then
    env.info("CarrierDebugMode is enabled")
    env.info("MarkerSpacingInHours: " .. MarkerSpacingInHours)
    env.info("NumberOfMarkersToPlot: " .. NumberOfMarkersToPlot)
    env.info("TypeNamesOfCarriersToInclude: " .. table.concat(TypeNamesOfCarriersToInclude, ", "))
    env.info("UnitNamesOfCarriersToExclude: " .. table.concat(UnitNamesOfCarriersToExclude, ", "))
end
findTheCarriers()
if CarrierDebugMode then env.info("Total blue carriers found: " .. #blueCarriers .. ", plotting future positions...") end
plotFuturePositions(blueCarriers)
if CarrierDebugMode then env.info("Total red carriers found: " .. #redCarriers .. ", plotting future positions...") end
plotFuturePositions(redCarriers)
if CarrierDebugMode then env.info("Total neutral carriers found: " .. #neutralCarriers .. ", plotting future positions...") end
plotFuturePositions(neutralCarriers)
env.info("GTFreeFlyer's Carrier Map Position Plotter v1.0 loaded successfully")