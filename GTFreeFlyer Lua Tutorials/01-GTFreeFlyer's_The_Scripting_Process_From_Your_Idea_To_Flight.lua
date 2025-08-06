--Copywrite 2020.  "GTFreeFlyer"
--This tutorial is free to distribute.  It may not be altered, sold, or used for revenue generation without written permission from GTFreeFlyer.  Contact GTFreeFlyer@yahoo.com.
--Use of any poriton of this tutorial requires proper credit given.  i.e. "Example copied from GTFreeFlyer's tutorials."  The credit must include a link to where others can find the tutorials.
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--Hi there and welcome back.  GTFreeFlyer here.
--I'm now going to show you the whole process from start to finish.

--You will NOT be learning how to do any scripting in this tutorial.
--This tutorial will show you how to go from creation of a script, bring it in through the mission editor, and into actual gameplay.
--If you already know how to do this, you can skip this tutorial and go to the next one.
--The purpose of this tutorial is to show the total noob how it's done, otherwise you'll be going through the tutorials thinking, "Scripting is great, but how do I actually use it?"
--Here, you'll see the whole process, that way you'll know how scripts are used in DCS as you go through my tutorials.

--Nice, let's coninute.
--At the very bottom of this tutorial is some actual code which we will run.  Yup, we are going to load this exact .lua you are reading right now, so don't edit this and resave it!
--Remember, any line of code that begins with a double dash (--) is only a comment, and is completely ignored when a script runs.
--That is why we are able to load this tutorial into DCS.  It will ignore everything I say - kind of like you are doing right now - and will only look at the stuff at the bottom of this script.
--Don't worry about reading the actual code at the bottom of this tutorial and trying to figure out how it works.  That's not what this tutorial is about.
--You'll be able to easily read it, understand it, AND write similar code after a few more tutorials.   

--Alright, let's begin.  Follow these steps EXACTLY to get your script into the mission:
--1.  Open up DCS
--2.  From the main menu, select Mission Editor
--3.  Choose Create New Mission
--4.  Select any map you want.  Leave the coalitions as is.  Click OK.
--5.  Once you are looking at the map, click the airplane icon on the left of the screen, "Add or modifiy airplane group"
--6.  Click anywhere on the map to place your aircraft.
--7.  You now have that plane's data popped up on the right of your screen.
--8.  Leave everything as default. Group Name should be "New Airplane Group", Pilot should be "Aerial 1-1", etc.  DO NOT CHANGE.
--9.  However we must change some things.  Under "Type", choose an aircraft module that you do have.
--10. Set "Skill" to "Player"
--11. In the next section below, choose an altitude that will keep you clear of terrain.
--12. Now right-click anywhere on the map to deselect your plane.
--13. Along the left side of your screen, click the 6th icon from the top, "Set rules for triggers"
--14. You now see 3 empty boxes, "Triggers", "Conditions", and "Actions"
--15. Under the Triggers box, click "New".
--16. Set TYPE to "1 ONCE", and give it any name you want (or leave it as is).
--17. Under the empty Conditions box, click "New".
--18. Set TYPE to "TIME MORE", and set "SECONDS" to 5.
--19. Under the empty Actions box, click "New".
--20. Set ACTION to "DO SCRIPT FILE".
--21. To the right of FILE, click OPEN
--22. Navigate to this tutorial .Lua that you are reading, select it and click OK.  (YOU HAVE TO redo this each time you make a change to your Lua script once you start scripting on your own)
--23. Left-click on the map to close the triggers window.
--24. On the left of your screen, click the icon that is a green circle with an up-arrow, "Fly Mission".
--25. If prompted to save your mission, choose "Yes" or "No"
--26. From the briefing page, click START
--27. From the next briefing page, click FLY
--28. Sit back and watch the script in aciton!  It will begin in 5 seconds.  Look at the top-right of the screen to see the messages. If you don't see messages and an explosion, you did something wrong.

--Congrats, you now know how to take a .lua script, load it in through the Mission Editor, and go flying with it!

--Cheers,
--GT, out!

trigger.action.outText("Congrats! You have loaded the script successfully.", 5)
timer.scheduleFunction(function() trigger.action.outText("You know it's running because you can see these messages.", 5) end, nil, timer.getTime() + 5)
timer.scheduleFunction(function() trigger.action.outText("Alright, let's finish up here.  Use the F10 radio menu to select End Tutorial.", 60, true) end, nil, timer.getTime() + 10)
mytimer = 6
function endTutorial()
    mytimer = mytimer - 1
    if mytimer ~= 0 then
        trigger.action.outText("This tutorial will self-destruct in " .. mytimer, 1, true)    
        timer.scheduleFunction(endTutorial, nil, timer.getTime() + 1)
    else        
        _name = Unit.getByName("Aerial 1-1") -- _name return is a class, not a string
        trigger.action.explosion(_name:getPosition().p, 1000) 
        trigger.action.outTextForGroup(_name.getGroup():getID(), "Tutorial finished.  See you next time!", 60, true)
    end
end
missionCommands.addCommand("End Tutorial", nil, endTutorial, nil)
