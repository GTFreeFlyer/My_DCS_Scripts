    --Script by GTFreeFlyer, April 28, 2025
    --v1: Initial release
  
    --the lines below build the fog menu into the F10 menu
    fogMenu = missionCommands.addSubMenu("Adjust fog", nil)
        --format for the setFogAnimation function is {fade time (sec), visibility (meters), thickness (meters)} 
        missionCommands.addCommand("Random fog now",          fogMenu, 
            function()  
                _fogFadeTime = 3 --in seconds, this is how long it takes the fog to fade from current setting to the new setting
                _fogVisibility =math.random(1852, 50000)--in meters, must be between 100 and 100000
                _fogThickness = math.random(100, 2500) --in meters, must be between 100 and 5000               
                
                world.weather.setFogAnimation({ {_fogFadeTime, _fogVisibility, _fogThickness } }) 

                _fogVisibility =  math.floor(_fogVisibility*.00054) -- convert to nMi and round down to nearest nmi
                _fogThickness = math.floor(_fogThickness*3.28084/100)*100 -- convert to ft and round down to nearest 100 ft

                trigger.action.outText("Fog set to " .. _fogVisibility .. " nMi visibility, " .. _fogThickness .. ", ft thick.", 5)
                trigger.action.setUserFlag("randomFog", true)
            end, nil)
        missionCommands.addCommand("No fog in 1 min",         fogMenu, function()  world.weather.setFogAnimation({ {60, 0, 0} })         trigger.action.setUserFlag("randomFog", false) end, nil)
        missionCommands.addCommand("No fog in 30 min",        fogMenu, function()  world.weather.setFogAnimation({ {1800, 0, 0} })       trigger.action.setUserFlag("randomFog", false) end, nil)
        missionCommands.addCommand("Light fog in 1 min",      fogMenu, function()  world.weather.setFogAnimation({ {60,10000, 1500} })   trigger.action.setUserFlag("randomFog", false) end, nil)
        missionCommands.addCommand("Light fog in 30 min",     fogMenu, function()  world.weather.setFogAnimation({ {1800,10000, 1500} }) trigger.action.setUserFlag("randomFog", false) end, nil)
        missionCommands.addCommand("Medium fog in 1 min",     fogMenu, function()  world.weather.setFogAnimation({ {60, 4000, 700} })    trigger.action.setUserFlag("randomFog", false) end, nil)
        missionCommands.addCommand("Medium fog in 30 min",    fogMenu, function()  world.weather.setFogAnimation({ {1800, 4000, 700} })  trigger.action.setUserFlag("randomFog", false) end, nil)
        missionCommands.addCommand("Heavy low fog in 1 min",  fogMenu, function()  world.weather.setFogAnimation({ {60, 1600, 250} })    trigger.action.setUserFlag("randomFog", false) end, nil)
        missionCommands.addCommand("Heavy low fog in 60 min", fogMenu, function()  world.weather.setFogAnimation({ {1800, 1600, 250} })  trigger.action.setUserFlag("randomFog", false) end, nil)
        missionCommands.addCommand("Crazy fog in 1 min",      fogMenu, function()  world.weather.setFogAnimation({ {60, 300, 700} })     trigger.action.setUserFlag("randomFog", false) end, nil)

--Instructions if you want to add random fog at start of mission:
--Trigger setup: 
-----MISSION START, name it "INITIAL RANDOM FOG"
-----No conditions. Leave blank.  Or Time More (x), whichever you prefer.
-----Actions:
----------FLAG ON, "randomFog"
----------DO SCRIPT:
--------------- _fogFadeTime = 2 --in seconds, this is how long it takes the fog to fade from current setting to the new setting
--------------- _fogVisibility =math.random(1800, 50000)--in meters, must be between 100 and 100000
--------------- _fogThickness = math.random(100, 2500) --in meters, must be between 100 and 5000               
--------------- world.weather.setFogAnimation({ {_fogFadeTime, _fogVisibility, _fogThickness } }) 

--Instructions if you want to have random fog every 5 minutes (300 seconds):
--Trigger setup (in addition to the trigger above):
-----SWITCHED CONDITION, name it "PERIODIC RANDOM FOG"
-----Conditions:
----------TIME SINCE FLAG, "randomFog", 300
-----Actions:
----------FLAG OFF, "randomFog"
----------FLAG ON, "randomFog"
----------DO SCRIPT:
--------------- _fogFadeTime = 300 --in seconds, this is how long it takes the fog to fade from current setting to the new setting
--------------- _fogVisibility = math.random(1800, 50000)--in meters, must be between 100 and 100000
--------------- _fogThickness = math.random(100, 2500) --in meters, must be between 100 and 5000               
---------------                 
--------------- world.weather.setFogAnimation({ {_fogFadeTime, _fogVisibility, _fogThickness } }) 
--------------- 
--------------- _fogVisibility = math.floor(_fogVisibility*.00054) -- convert to nMi and round down to nearest nmi
--------------- _fogThickness = math.floor(_fogThickness*3.28084/100)*100 -- convert to ft and round down to nearest 100 ft
--------------- 
--------------- trigger.action.outText("The forecast shows fog " .. _fogVisibility .. " nMi visibility, " .. _fogThickness .. " ft thick, five minutes from now.", 15)