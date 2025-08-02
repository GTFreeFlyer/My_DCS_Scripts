--Copywrite 2020.  "GTFreeFlyer"
--This tutorial is free to distribute.  It may not be altered, sold, or used for revenue generation without written permission from GTFreeFlyer.  Contact GTFreeFlyer@yahoo.com.
--Use of any poriton of this tutorial requires proper credit given.  i.e. "Example copied from GTFreeFlyer's tutorials."  The credit must include a link to where others can find the tutorials.
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--Just a quick note:  You may have already noticed that another tutorial of mine is called the "Advanced F10 Menu Tutorial"...
--It is like this "Simple" tutorial, but it shows you how to do more advanced things like building submenus and removing items from a table once you put them in there.
--You can't do that without knowing tables, so the tables tutorial will be required first.  What you'll learn in this tutorial is the quick and easy method, with limited functionality.
--You could probably skip this tutorial if you'd like, but sometimes it's better to know the quick and simple method.  This tutorial is a quick one anyway... 

--Okay, so this quick lesson will show you how to set up an F10 menu structure...

--When you first open comm menu and see "F10 other...", you can populate the list with three items using the following command lines:
local FirstItemMenu = missionCommands.addSubMenu("1st option", nil)
local SecondItemMenu = missionCommands.addSubMenu("2nd option", nil)
local ThirdItemMenu = missionCommands.addSubMenu("Favorite Plane?...", nil)

--Confused now?  Don't be.  Let's look at that first item menu in detail...
--"local" is just something you need to type before defining your variable to let the compiler know you want the variable to exist only in this program - or function - and not to be used in other functions
----Don't confuse yourself with it.  Just know that you should put it there, even though there will be times where you won't want the variable to be "local"... Again, just ignore it for now.
--"FirstItemMenu" is the name of your variable.  This can be any name you want it to be as long as it doesn't match a preprgrammed LUA word.
--Next, we type "=" so that we can define what we want our variable to be.  in this case, we want it to be a DCS menu.
--You could simply type local FirstItemMenu = 10, and it will be 10, but that's not what we want.
--DCS editor has a pre-programmed command for adding a menu item, as you see above.  its format is...
--missionCommands.addSubMenu("this is the text you'll see on screen", variable_of which_menu_it_belongs_to)
--In the first line above, we use "nil" because the 1st option is at the top of the menu structure and doesn't belong to anything else
--Also note that I placed three dots after "Favorite Plane?".  I did this to show you an example later on.  If DCS knows...
--...that you have another tree level below this, it will automatically add the 3 dots for you.  You don't need to do it.
--We'll show this by adding another level under that, so the display on the screen should show the 3 dots I placed there, plus the 3 automatic dots.
--Okay, so now we add a 2nd menu and 3rd menu just for fun and example

--Let's now add some menu items to that third menu option for "Favorite Plane?"
--Remember, you'll see it as "Favorite Plane?" on the screen, but that's not what the code thinks it is.
--We defined that menu option as the variable, "ThirdItemMenu"

--Here we go, let's make another level in our menu tree... 
local HornetMenu = missionCommands.addSubMenu("Hornet", ThirdItemMenu)
local HogMenu = missionCommands.addSubMenu("Hog", ThirdItemMenu)

--And one more level for each...
local ConfirmItPlease1 = missionCommands.addSubMenu("You sure?", HornetMenu)
local ConfirmItPlease2 = missionCommands.addSubMenu("You sure?", HogMenu)

--So that's the same as before, except now we don't type "nil". Instead, we type which menu we want this to belong to.
--Now we'll enter that menu and execute a command.  We don't need to define a local variable here, so we just jump straight into the command...
--For this example, we'll set a flag to "true" or "false" based on your answer...
missionCommands.addCommand("Yes", ConfirmItPlease1, function() trigger.action.setUserFlag(1, true) end, nil)
missionCommands.addCommand("No", ConfirmItPlease1, function() trigger.action.setUserFlag(1, false) end, nil)
missionCommands.addCommand("Yes", ConfirmItPlease2, function() trigger.action.setUserFlag(2, true) end, nil)
missionCommands.addCommand("No", ConfirmItPlease2, function() trigger.action.setUserFlag(2, false) end, nil)

--As you see above, the format is now missionCommands.addCommand("Text you'll see on screen", menu_it_belongs_to, DCS_command_action, nil)
--The DCS command action can be any of the DCS LUA commands from their catalog of built-in functions.  Research the web for those.
--It should be obvious that we are setting Flag #1 to true or false based on your answer for the Hornet, and Flag #2 for the Hog.

--That's pretty much it.  
--If you'd like to try it out and see how it works, go ahead and save this file as something else, and delete all the lines of code below this line.
--Then, you can load that script file just like you did in Lesson 1, but wait! Just read the next few lines first... 

--Now all the stuff below (that I mentioned you can delete) is the same as all the lines of code above but I'll present it in two different ways.
--The order of the lines above doesn't matter, but if you want to be able to read it easily, you need to pick which way makes most sense to your brain when you are looking at code.

--The first method I present to you is EXACTLY the same order as above, but with the comments removed so that you can see how short the script is.
--Go ahead and compare it to all the lines of code you see above.  See?  It's the same exact stuff in the same exact order.
local FirstItemMenu = missionCommands.addSubMenu("1st option", nil)
local SecondItemMenu = missionCommands.addSubMenu("2nd option", nil)
local ThirdItemMenu = missionCommands.addSubMenu("Favorite Plane?...", nil)

local HornetMenu = missionCommands.addSubMenu("Hornet", ThirdItemMenu)
local HogMenu = missionCommands.addSubMenu("Hog", ThirdItemMenu)

local ConfirmItPlease1 = missionCommands.addSubMenu("You sure?", HornetMenu)
local ConfirmItPlease2 = missionCommands.addSubMenu("You sure?", HogMenu)

missionCommands.addCommand("Yes", ConfirmItPlease1, function() trigger.action.setUserFlag(1, true) end, nil)
missionCommands.addCommand("No", ConfirmItPlease1, function() trigger.action.setUserFlag(1, false) end, nil)
missionCommands.addCommand("Yes", ConfirmItPlease2, function() trigger.action.setUserFlag(2, true) end, nil)
missionCommands.addCommand("No", ConfirmItPlease2, function() trigger.action.setUserFlag(2 false) end, nil)

--Perhaps it's a little tough to follow?  Try reordering and indenting some lines, and you find something easier to read and make sense of:
--Note:  Indenting is optional, like adding comments.  The script won't care if there are indents or spaces at the beginning of your line of code.  It is for you to organize it for your brain's readability.
--The style below is the style I prefer and use, but your mileage may vary if you like the other way above.
--See here...

local FirstItemMenu = missionCommands.addSubMenu("1st option", nil)
local SecondItemMenu = missionCommands.addSubMenu("2nd option", nil)
local ThirdItemMenu = missionCommands.addSubMenu("Favorite Plane?...", nil)
    local HornetMenu = missionCommands.addSubMenu("Hornet", ThirdItemMenu)
        local ConfirmItPlease1 = missionCommands.addSubMenu("You sure?", HornetMenu)
            missionCommands.addCommand("Yes", ConfirmItPlease1, function() trigger.action.setUserFlag(1, true) end, nil)
            missionCommands.addCommand("No", ConfirmItPlease1, function() trigger.action.setUserFlag(1, false) end, nil)
    local HogMenu = missionCommands.addSubMenu("Hog", ThirdItemMenu)
        local ConfirmItPlease2 = missionCommands.addSubMenu("You sure?", HogMenu)
            missionCommands.addCommand("Yes", ConfirmItPlease2, function() trigger.action.setUserFlag(2, true) end, nil)
            missionCommands.addCommand("No", ConfirmItPlease2, function() trigger.action.setUserFlag(2, false) end, nil)

--Again, to claify, these are the EXACT same lines of code as we orginally wrote together, just reordered and indented to make it easier to see what is going on.
--Now if you'd like to try this script out, go ahead and save this script as something else on your hard drive - sorry, I grew up in different times - I meant to say Solid State Drive...
--Next, in the other file you saved, go ahead and delete everything above line 85 of this script, so that you are left with only the one chuck of code.
--Finally, load it into your mission just like you did in lesson 1, then go ahead and fly, and pull up the F10 radio menu to check it out.

--Hope you enjoyed!
--Cheers,
--GT, out!