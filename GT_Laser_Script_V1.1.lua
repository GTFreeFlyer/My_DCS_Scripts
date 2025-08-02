--[[

GTFreeFlyer's Laser Script
Version 1.0
Free to distruibute or use for any purpose, including commercial purposes.
Send a PM to GTFreeFlyer in the ED Forums for support. 
Cheers!

Purpose:
Creates a laser from any object to another object, stationary or moving. 

Installation Instructions:
1. Place this LUA file anywhere on your PC.
2. Create a mission trigger with an action of "Do Script File" and then select this file.  It should be loaded at mission start or any time before you plan to use the script.
....Once you do this, the Mission Editor will load this file into your .miz file and you will no longer need the original LUA file that you downloaded.

Usage Instructions:
1. In the mission editor, create a trigger with any conditions you like.  Set the action to "Do Script".
2. In the "Do Script" text-entry box, type any of the following commands from the examples below.  Obviously, change as needed to match your mission

FORMAT OF ACCEPTABLE COMMANDS:
addLaser(Source, Target, Code, IR pointer)
...or...
removeLaser(Code)

EXAMPLE 1
addLaser('Darth Vador', 'Poor little bastard', 1666, true)
...where the first entry is your laser's source (where the laser is coming from).  It must match the unit's name as defined in the Mission Editor. Note: It is case-sensitive and requires the quotes.
...where the second entry is your laser's target (where the end of the laser beam is).  It must match the unit's name as defined in the Mission Editor. Note: It is case-sensitive and requires the quotes.
...where the third entry is the laser's code.
...where the 4th entry is OPTIONAL. If blank (only 3 entries), you'll get a laser only.  If true, you'll get a laser AND an IR pointer

EXAMPLE 2
addLaser('Predator UAV', {x=12345, y=3, z=56789}, 1688)
...note here you can also set the target (the 2nd entry) as specific coordinates. Set your Mission Editor to display X,Y,Z coordinates instead of Lat/Lon and use X,Y,Z.  Enclose in braces {}, not quotes.
...Note: The Y-coordinate is your altitude in meters.  If you want to put the laser on a specific window of a high-rise building, you may need to add a few meters to what the Mission Editor shows you.

EXAMPLE 3
removeLaser(1688)
...Very simple, just enter the laser code you wish to remove.

That's it!  There's no need to read any further.  Do not edit any of the lines below.

-GTFreeFlyer, out!  (Hey! I told you there was no need to read any further!)

--]]

GT_LaserDesignations = {}
GT_LaserBeams = {}
GT_IRPointers = {}

function updateLasers()
    for _laserNumber, _laserBeam in ipairs(GT_LaserBeams) do
        _laserBeam:destroy()
        GT_IRPointers[_laserNumber]:destroy()
        
        _GTSource = Unit.getByName(GT_LaserDesignations[_laserNumber][1])

        if type(GT_LaserDesignations[_laserNumber][2]) == 'string' then
            _GTTarget = Unit.getByName(GT_LaserDesignations[_laserNumber][2]):getPoint()
        elseif type(GT_LaserDesignations[_laserNumber][2]) == 'table' then
            _GTTarget = GT_LaserDesignations[_laserNumber][2]
        end

        GT_LaserBeams[_laserNumber] = Spot.createLaser(_GTSource, {x=0, y=1, z=0}, _GTTarget, GT_LaserDesignations[_laserNumber][3])
        GT_IRPointers[_laserNumber] = Spot.createInfraRed(_GTSource, {x=0, y=1, z=0}, _GTTarget)
    end
    timer.scheduleFunction(updateLasers, nil, timer.getTime() + .333)
end

function addLaser(GTSource, GTTarget, GTCode, GTPointer)
    _GTSource = Unit.getByName(GTSource)
    if type(GTTarget) == 'string' then
        _GTTarget = Unit.getByName(GTTarget):getPoint()
    elseif type(GTTarget) == 'table' then
        _GTTarget = GTTarget
    end
    GT_LaserBeams[#GT_LaserBeams + 1] = Spot.createLaser(_GTSource, {x=0, y=1, z=0}, _GTTarget, GTCode)
    GT_IRPointers[#GT_IRPointers + 1] = Spot.createInfraRed(_GTSource, {x=0, y=1, z=0}, _GTTarget)
    table.insert(GT_LaserDesignations, {GTSource, GTTarget, GTCode})
end

function removeLaser(GTCode)
    for _index, _value in ipairs(GT_LaserDesignations) do
        if _value[3] == GTCode then
            table.remove (GT_LaserDesignations, _index)
            table.remove (GT_LaserBeams, _index)
            table.remove (GT_IRPointers, _index)
            break
        end
    end
end

updateLasers()

--Format: GT_LaserDesignations = {  {Source, Target, Code, IR pointer}, ...}
--Example: GT_LaserDesignations = {  {'Harrier 103', 'T-55 No.4', 1688}, {'Warrior_JTAC', 'Poor little bastard', 1666, true}, {'Predator UAV', {x=12345, y=3, z=56789}, 1666}   }