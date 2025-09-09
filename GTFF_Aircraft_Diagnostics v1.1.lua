-- GTFF_Aircraft_Diagnostics.lua, v1, 2025-08-17
-- By, GTFreeFlyer.  You may reach out to me on Discord or ED Forums, same username, for support, questions, or suggestions.
-- Special thanks to Super Wabbit for help with testing this script and providing feedback.

------- VERSION HISTORY------------------------------------------------------------------
-- v1, 2025-08-17, initial relaease
-- v1.1, 2025-09-08, no changes other than instructions on how to set up the script.

------- DESCRIPTION------------------------------------------------------------------
-- Shows the health and fuel consumption of the player's aircraft "testAircraft" in the top right corner, updating every second.
-- It will only work for a single aircraft, and it assumes the aircraft GROUP NAME is named "testAircraft".  The unit name can be whatever you like.
-- If you prefer another group name, change the GROUP_NAME variable below, in the USER SETTINGS section.

-- Note: Fuel efficiency is calculated based on the 2D ground speed and fuel consumption rate, NOT based on true airspeed.
--       This allows you to check best engine settings for upwinds and downwinds and maximize your range
--       I recommend setting zero wind in your test mission for the initial characterization of your aircraft.

------- INSTALLATION------------------------------------------------------------------
-- Place file anywhere you would like on your computer.
-- In the Mission Editor, create new trigger, load at mission start, no condition req'd, for the action select "DO SCRIPT FILE" and choose this file.
-- Drop a single aircraft into the mission, and name the group "testAircraft" (or change the GROUP_NAME variable below).
-- Fly!
-- Take notes and share aircraft performance with the DCS community!


------- USER SETTINGS------------------------------------------------------------------
local GROUP_NAME = "testAircraft"
local FUEL_TANK_CAPACITY = 237 -- Gallons.  Set this to the maximum fuel tank capacity of your aircraft, NOT including external tanks.  It should be the internal fuel capacity only.
                               --If set to any number other than 0, the display will show you gallons of fuel, and gallons per per hour burn rate.
                               --If set to 0, the display will show you % fuel, and % fuel per hour burn rate.

------- USER NOTES: (place your notes here)------------------------------------------------------------------
--The F4U Corsair has a tank with 237 gallons of fuel, which includes the 50 gallon reserve standpipe.
--Use 370 gallons as the capacity for the P-47D Thunderbolt

------ Do not change the code below this line------------------------------------------------
local lastFuel = nil
local lastTime = nil

local function showAircraftDiagnostics()
    local group = Group.getByName(GROUP_NAME)
    if group then
        local unit = group:getUnit(1)
        if unit and unit:isExist() then
            local health = unit:getLife()
            local maxHealth = unit:getLife0()
            local healthPercent = (health / maxHealth) * 100

            local fuel = unit:getFuel() -- returns percent (0.0 - 1.0)
            local fuelPercent = fuel * 100
            local fuelGallons = fuel * FUEL_TANK_CAPACITY -- convert to gallons if FUEL_TANK_CAPACITY is set

            local groundSpeed_mps = unit:getVelocity() -- returns a Vec3 velocity in m/s
            local groundSpeed_kts = (math.sqrt(groundSpeed_mps.x^2 + groundSpeed_mps.z^2) * 3600) / 1852 -- convert m/s to knots

            local now = timer.getTime()
            local fuelConsumptionPerHour = nil

            if lastFuel and lastTime then
                local fuelDelta = lastFuel - fuel
                local timeDelta = now - lastTime
                if timeDelta > 0 then
                    fuelConsumptionPerHour = (fuelDelta / timeDelta) * 3600 * 100 -- percent per hour
                    fuelEfficiency_PPH = (groundSpeed_kts / fuelConsumptionPerHour) -- Nmi per percent
                    gallonsPerHour = fuelConsumptionPerHour / 100 * FUEL_TANK_CAPACITY -- percent per hour
                    fuelEfficiency_GPH = (groundSpeed_kts / gallonsPerHour) -- Nmi per gallon
                end
            end

            local msg
            if fuelConsumptionPerHour and FUEL_TANK_CAPACITY == 0 then
                msg = string.format(
                    "Aircraft Health: %.1f%%\nFuel: %.1f%%\nFuel Consumption: %.1f%%/hr\nFuel Efficiency: %.2f Nmi/%% fuel\nGround Speed: %.1f kts",
                    healthPercent, fuelPercent, fuelConsumptionPerHour, fuelEfficiency_PPH, groundSpeed_kts
                )
            elseif fuelConsumptionPerHour and FUEL_TANK_CAPACITY ~= 0 then
                msg = string.format(
                    "Aircraft Health: %.1f%%\nFuel: %.1f gal\nFuel Consumption: %.2f GPH\nFuel Efficiency: %.2f Nmi/gal\nGround Speed: %.1f kts",
                    healthPercent, fuelGallons, gallonsPerHour, fuelEfficiency_GPH, groundSpeed_kts
                )
            else
                msg = string.format(
                    "Aircraft Health: %.1f%%\nFuel: %.1f%%\nFuel Consumption: --",
                    healthPercent, fuelPercent
                ) 
            end

            trigger.action.outTextForGroup(group:getID(), msg, 1, true)

            lastFuel = fuel
            lastTime = now
        else
            trigger.action.outTextForGroup(group:getID(), "Aircraft not found or destroyed.", 1, true)
        end
    end
    timer.scheduleFunction(showAircraftDiagnostics, {}, timer.getTime() + 1)
end

-- Start the diagnostics display loop
showAircraftDiagnostics()