-- Ships_in_Sector_v5_2025-08-13.lua
-- by GTFreeFlyer
-- DCS World script: Calculates which sector each enemy ship is in, relative to each blue Essex.
-- Use of this script is permitted for any purpose, commercial or non-commercial, provided that the author is acknowledged.
-- Please include in your briefing, "Ships in Sector script by GTFreeFlyer".

--v5: Updated sectors based on today's DCS update.

--Brief description: This script will report the sectors of enemy ships, airplanes, and helicopters in relation to each Essex.

--Instructions:
-- 1. Place at least one blue Essex carrier in your mission.  
    --Each Essex unit name should be a two or three-letter code, e.g. "ESX" or "CV", as the Morse code will only braodcast the first three letters of the unit name.    
-- 2. If you want the script to detect an enemy ship, the unit name MUST begin with an underscore, e.g. "_RedShip1", if you want them to be detected.  This
    --is so that you can choose to ignore some units like little speedboats or whatever else.
    --All bandits will be detected, regardless of their unit name.
-- 3. Load this script in the mission editor via trigger action "DO SCRIPT FILE"
-- 4. Set the maximum maximum detection ranges below to the distance (in nautical miles) at which you want to be able to detect enemies.
-- 5. Set the onScreenTextTime variable below to the number of seconds you want the text to be displayed on screen.
-- 6. Create a trigger that runs this script whenever you want a report of where enemy ships are detected.
-- 7. I suggest hiding EVERYTHING from the F10 map so that you are forced to navigate like a true naval avaiator from the Essex days.
-- 8. Don't forget to include an image of the sectors pie chart and morse code identifier in you briefing, or on the kneeboard. 
local maximumShipDetectionRange = 150 -- nautical miles
local maximumAircraftDetectionRange = 150 -- nautical miles
local onScreenTextTime = 20 -- seconds
local banditMinimumHeight = 500 -- feet AGL, minimum height above ground level for bandits to be detected


--Do not change the code below this line-------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------
banditMinimumHeight = banditMinimumHeight * 0.3048 -- convert feet to meters for DCS


local function getShipsByCoalition(coalitionName)
    local ships = {}
    local groups = coalition.getGroups(coalitionName, Group.Category.SHIP)
    if groups then
    for _, group in ipairs(groups) do
            for _, unit in ipairs(group:getUnits()) do
                if unit:isActive() and coalitionName == coalition.side.BLUE and unit:getTypeName() == "Essex" then
                    table.insert(ships, unit)
                elseif unit:isActive() and coalitionName == coalition.side.RED and unit:getName():sub(1,1) == "_" and unit:getPoint().y > -8 then -- altitude check for submarines
                    table.insert(ships, unit)
                end
            end
        end
    end
    return ships
end

local function getBandits()
    local bandits = {}
    local categories = { Group.Category.AIRPLANE, Group.Category.HELICOPTER }
    for _, category in ipairs(categories) do
        local banditGroups = coalition.getGroups(coalition.side.RED, category)
        if banditGroups then
            for _, banditGroup in ipairs(banditGroups) do
                for _, banditUnit in ipairs(banditGroup:getUnits()) do
                    local AGL = banditUnit:getPoint().y - land.getHeight(banditUnit:getPoint())
                    if banditUnit:isActive() and AGL > banditMinimumHeight then
                        table.insert(bandits, banditUnit)
                    end
                end
            end
        end
    end
    return bandits
end

-- Helper function to calculate distance (meters) and heading (degrees) between two points
local function getDistanceAndHeading(fromUnit, toUnit)
    local p1 = fromUnit:getPoint()
    local p2 = toUnit:getPoint()
    local dx = p2.z - p1.z
    local dz = p2.x - p1.x
    local distance = math.sqrt(dx * dx + dz * dz) * .00054 --nMi
    local headingRad = math.atan2(dx, dz)
    local headingDeg = math.deg(headingRad)
    if headingDeg < 0 then headingDeg = headingDeg + 360 end
    return distance, headingDeg
end

local function getSector(_bearing)
    if _bearing >= 0 and _bearing < 15 then
        return "Lima"
    elseif _bearing >= 15 and _bearing < 45 then
        return "Echo"
    elseif _bearing >= 45 and _bearing < 75 then
        return "Alpha"
    elseif _bearing >= 75 and _bearing < 105 then
        return "Tango"
    elseif _bearing >= 105 and _bearing < 135 then
        return "Hotel"
    elseif _bearing >= 135 and _bearing < 165 then
        return "Oscar"
    elseif _bearing >= 165 and _bearing < 195 then
        return "Romeo"
    elseif _bearing >= 195 and _bearing < 225 then
        return "November"
    elseif _bearing >= 225 and _bearing < 255 then
        return "Uniform"
    elseif _bearing >= 255 and _bearing < 285 then
        return "Charlie"
    elseif _bearing >= 285 and _bearing < 315 then
        return "Kilo"
    elseif _bearing >= 315 and _bearing <= 345 then
        return "Sierra"
    elseif _bearing >= 345 and _bearing <= 360 then
        return "Lima"
    else
        return "**script error**"
    end
end

-- Main logic
local blueShips = getShipsByCoalition(coalition.side.BLUE) --contains a table of all the blue ships
local redShips = getShipsByCoalition(coalition.side.RED) --contains a table of all the red ships
local redBandits = getBandits() --contains a table of all the red bandit aircraft

-- Table to store results
shipDistances = {}
for _, blueShip in ipairs(blueShips) do
    local blueShipName = blueShip:getName()
    shipDistances[blueShipName] = {}
    
    --check enemy ships
    for _, redShip in ipairs(redShips) do
        local redShipName = redShip:getName()
        -- Calculate distance, heading and sector
        local distance, heading = getDistanceAndHeading(blueShip, redShip)
        if distance <= maximumShipDetectionRange then
            shipDistances[blueShipName][redShipName] = {
                distance = distance,
                heading = heading,
                sector = getSector(heading),
                category = "SHIP"
            }
        end
    end

    --check enemy bandits
    for _, redBandit in ipairs(redBandits) do
        local redBanditName = redBandit:getName()
        -- Calculate distance, heading and sector
        local distance, heading = getDistanceAndHeading(blueShip, redBandit)
        if distance <= maximumAircraftDetectionRange then
            shipDistances[blueShipName][redBanditName] = {
                distance = distance,
                heading = heading,
                sector = getSector(heading),
                altitude = redBandit:getPoint().y * 3.28, -- altitude above sea level in feet
                category = "AIRPLANE"
            }
        end
    end
end

--Count how many ships and bandits detected in each sector, for each friendly ship
for blueName, enemies in pairs(shipDistances) do
    --initialize count

    local sectorNames = {
        "Lima", "Echo", "Alpha", "Tango", "Hotel", "Oscar", "Romeo", "November",
        "Uniform", "Charlie", "Kilo", "Sierra" }

    -- Reset contact counts
    local shipContacts = {}
    local banditContacts = {}
    for _, sector in ipairs(sectorNames) do
        shipContacts[sector]   = 0
        banditContacts[sector] = 0
    end

    local anythingDetected = false

    -- Count ships and bandits in sectors
    for redName, info in pairs(enemies) do
        if info.category == "SHIP" then
            if shipContacts[info.sector] ~= nil then
                shipContacts[info.sector] = shipContacts[info.sector] + 1
                anythingDetected = true
            end
        elseif info.category == "AIRPLANE" then
            if banditContacts[info.sector] ~= nil then
                banditContacts[info.sector] = banditContacts[info.sector] + 1
                anythingDetected = true
            end
        end
    end

    -- Build the screen text
    local screenText = {}
    screenText[#screenText+1] = "Carrier "
    screenText[#screenText+1] = blueName
    screenText[#screenText+1] = " picture: "
    if anythingDetected then
        -- Report bandits in sectors
        for _, sector in ipairs(sectorNames) do
            local count = banditContacts[sector]
            if count > 0 then
                screenText[#screenText+1] = count
                if count == 1 then
                    screenText[#screenText+1] = " bandit in sector "
                else
                    screenText[#screenText+1] = " bandits in sector "
                end
                screenText[#screenText+1] = sector .. ". "
            end
        end

        -- Report ships in sectors
        for _, sector in ipairs(sectorNames) do
            local count = shipContacts[sector]
            if count > 0 then
                screenText[#screenText+1] = count
                if count == 1 then
                    screenText[#screenText+1] = " ship in sector "
                else
                    screenText[#screenText+1] = " ships in sector "
                end
                screenText[#screenText+1] = sector .. ". "
            end
        end
    else
        screenText[#screenText+1] = " Clean."
    end

    -- Print results to screen
    trigger.action.outTextForCoalition(coalition.side.BLUE, table.concat(screenText), onScreenTextTime)
end