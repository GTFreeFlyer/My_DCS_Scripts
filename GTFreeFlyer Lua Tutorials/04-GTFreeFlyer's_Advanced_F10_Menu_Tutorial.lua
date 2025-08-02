--Copywrite 2020.  "GTFreeFlyer"
--This tutorial is free to distribute.  It may not be altered, sold, or used for revenue generation without written permission from GTFreeFlyer.  Contact GTFreeFlyer@yahoo.com.
--Use of any poriton of this tutorial requires proper credit given.  i.e. "Example copied from GTFreeFlyer's tutorials."  The credit must include a link to where others can find the tutorials.
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--Welcome back.  
--Note: This lesson will put your Index-Values Tables knowledge to use.  We learned that in the last tutorial, and you'll get a refresher of it here.
--We don't go too much into detail about tables in this lesson, so you will probably be fine to continue if you haven't gone through my Index-Value Tables tutorial yet.

--Okay, so this quick lesson will show you how to set up an F10 menu structure...

--When you first open comm menu and see "F10 other...", you can populate the list with three items using the following command lines:
local FirstItemMenu = missionCommands.addSubMenu("1st option", nil)
local SecondItemMenu = missionCommands.addSubMenu("2nd option", nil)
local ThirdItemMenu = missionCommands.addSubMenu("Remaining Objectives...", nil)

--Confused now?  don't be.  let's look at that first item menu in detail...
--"local" is just something you need to type before defining your variable to let the compiler know you want the variable to exist only in this script and not to be shared across other scripts which might possibly be using the same exact variable name.
--Don't confuse yourself with it.  Just know that you need it there and put it there, even though there will be times where you won't want the variable to be "local"... again, just ignore it for now.
--"FirstItemMenu" is the name of your variable.  This can be any name you want it to be as long as it doesn't match a preprgrammed LUA word.
--Next, we type "=" so that we can define what we want our variable to be.  In this case, we want it to be a DCS menu.
--You could simply type "local FirstItemMenu = 10" (without the quotes), and it will be 10, but that's not what we want.
--DCS editor has a pre-programmed command for adding a menu item, as you see above.  Its format is...
--missionCommands.addSubMenu("this is the text you'll see on screen", variable_of_which_menu_it_belongs_to)
--In the first line above, we use "nil" because the 1st option is at the top of the menu structure and doesn't belong to anything else.
--Also note that I placed three dots after "Remaining Objectives".  I did this to show you an example later on.  
--If DCS knows that you have another tree level below this, it will automatically add the 3 dots for you.  You don't need to do it.
--We'll show this by adding another level under that, so the display on the screen should show the 3 dots I placed there, plus the 3 automatic dots.
--Ok, so now we want to add a 2nd-level submenu and 3rd-level submenu just for fun and example.

--Let's now add some menu items to that third menu option for "Remaining Objectives"
--Remember, you'll see it as "Remaining Objectives" on the screen, but that's not what the code thinks it is.  We defined that menu option as the variable, "ThirdItemMenu"

--Here we go, let's make another level in our menu tree...
--First, since you are doing so well, let's have another quick lua lesson:  
--Let's create something called a "table".  Since we aren't going to make a complicated lua table, just think of it as a "list", but I'll continue to refer to it as a table.
--A lua table is a set of "things" contained inside braces {}.
--GTsExampleTable = {"This is my first entry", "And this is my 2nd", "and both don't have to be words, known as strings", "they could be numbers like", 4, "or math like", 6-2, "or variables like", tempVariable}
--As you see above, I created a table called GTsExampleTable, and it has 9 entries, which must be separated by commas.
--Now, if I want to call up the 4th item in a table and save it as a new variable called GTsNewVariable, I would use square brackets [] for the index position.  It would look like this...
--GTsNewVariable = GTsExampleTable[4]
--Now, if I were to print GTsNewVariable on screen, I would see this, "they could be numbers like" (without the quotes)
--If I printed GTsExampleTable[7] to screen I would see "4" show up without the quotes.  6 minus 2 is 4, correct?  I'm not so good at math, so let's get past this...
--Ok good, that was super easy wasn't it?
--We don't have to use tables to do submenus in DCS, but if we want to be able to remove items from a submenu then we must use tables, which is why this tutorial is called my "Advanced Tutorial", but it's really easy!
--Don't think it's easy?  Well that's only because it is new to you and you'll get the hang of it in no time, so just hang in there.
--Now let's create a submenu.
--The first thing we need to do is give our submenu a name, and define it as a table so that lua can except it to be a table, and not a number, string, etc.

local ObjectivesSubMenu = {}

--There we go.  We created a new variable and told lua that it is a table by setting it equal to an empty table {}.
--Moving forward, we don't have to define it as "local" anymore since we've already done that above.
--Now each index position inside this table will be an item in your submenu that will appear in your game F10 submenu.

ObjectivesSubMenu[1] = missionCommands.addSubMenu("Air Objectives", ThirdItemMenu)
ObjectivesSubMenu[2] = missionCommands.addSubMenu("Ground Objectives", ThirdItemMenu)

--You can see we now set index positions 1 and 2 equal to the two objectives you see above (Air objectives and ground objectives)
--... and we have set them to belong to the "ThirdItemMenu", which you will see in your F10 menu as "Remaining Objectives".
--So now, when you go to your F10-Other menu, you will see "Remaining Objectives", and when you click on that you will see two more items, Air Objectives and Ground Objectives.
--Now let's add some specific ground objectives...
--First, create another table, then add items as separate index positions:

GroundObjectivesSubMenu = {}
GroundObjectivesSubMenu[1] = missionCommands.addSubMenu("Destroy factory in Batumi", ObjectivesSubMenu[2])
GroundObjectivesSubMenu[2] = missionCommands.addSubMenu("Eliminate SA-10 near Kobuleti", ObjectivesSubMenu[2])
GroundObjectivesSubMenu[3] = missionCommands.addSubMenu("Eliminate T-72 column", ObjectivesSubMenu[2])
GroundObjectivesSubMenu[4] = missionCommands.addSubMenu("Sink enemy submarine", ObjectivesSubMenu[2])

--As you see above, we added each of those 4 index positions to the same location, ObjectivesSubMenu[2], which is our submenu for "Ground Objectives".
--Now when you click on "Ground Objectives" in the F10 menu, you will see these 4 remaining objectives.
--However, if you click on any of these 4 items, you've reached the end of the tree and the F10 menu will simply close and no action will be taken.
--Perhaps this is what you want? Only a list of remaining objectives and nothing further?
--Well, how about we add a command so that if you click on one of these objectives, you'll receive a message telling you exactly where the objective is located?
--Here we go, let's do it.  Just two quick examples of two (of the many) things you can do:

--Previously we used the missionCommands.addSubMenu command, but now we must use missionCommands.addCommand since we are adding commands:
--The first thing to do is replace the line above (GroundObjectivesSubMenu[1] = missionCommands.addSubMenu("Destroy fatory in Batumi", ObjectivesSubMenu[2]) ) with the following line:
GroundObjectivesSubMenu[1] = missionCommands.addCommand("Destroy factory in Batumi", ObjectivesSubMenu[2], function() trigger.action.outText("Factory is located in Grid 37TMN123456", 15, false) end, nil)

--Ok, what!?  Don't be scared.  Let's break it down...
--First, you can see we changed addSubMenu to addCommand.  This is required if you want the F10 option to do something once you click on it.  Ok, that was easy... what's next?
--Next, you see that the first two arguments in the parenthesis stay the same.  The first one is the text as you want it displayed in the game F10 menu.  The 2nd is which submenu you'd like this command to belong to.
--Phew, easy, all the same.  What's with the next two arguments?
--Well, if you check out https://wiki.hoggitworld.com/view/DCS_func_addCommand, you can see the third argument must be some sort of function to run, and the 4th argument would be any other arguments you want to pass along into the function you just specified.
--Arrrrgh! WTH?  Don't worry, this is only the advanced tutorial, and not the super-advanced tutorial, so we won't be passing along any additional arguments, so just put "nil" (without quotes) for that 4th argument and forget about it!
--Ok, back to that 3rd argument, the function:
--Well, that function is written out in one line, but you can think of it as follows:

--function()
--  trigger.action.outText("Factory is located in Grid 37TMN123456", false)
--end

--Above, you see we are defining a function, it only contains one line of instruction, then we close the function with the "end" command.
--Now let's break down that outText action:
--trigger.action.outText is another command that is specific to DCS.  You cannot use it in any other lua scripts that you write.  Only DCS understands what this is.
--Again, you can go to the wiki to see how to use it: https://wiki.hoggitworld.com/view/DCS_func_outText
--And you can also see here all the different things you can do for DCS: https://wiki.hoggitworld.com/view/Category:Functions
--Ok, but back to this specific example, trigger.action.outText takes three arguments inside the parenthesis: 
--The 1st argument is the text that you would like to see printed on your screen in DCS.  You must place this in quotes as shown above.
--The 2nd argument is the time in seconds of how long you'd like the message to stay on screen.
--The 3rd argument is whether or not you want clearview and you simply put true or false as the 3rd argument (it must be all lowercase as you see above!)
--What is clearview?  If clearview is true, then this message will overwrite any other message that might curently be displayed on your screen...
--...which means you might miss that previous message if it was up for only .25 seconds before this new message pops up.
--If you set clearview to be false, then your message will simply print on screen below the message that is currently on screen.

--Ok we are done!  Now if you click on "Destroy factory in Batumi" in your F10 menu, you'll get the message telling you where it is.
--But wait, there's more!
--It is common to want to set flag values when you click on things in the F10 menu.
--Let's replace that last line we looked at with this line:
GroundObjectivesSubMenu[1] = missionCommands.addCommand("Destroy factory in Batumi", ObjectivesSubMenu[2], function() trigger.action.setUserFlag(12, true) end, nil)
--Now when you click on "Destroy factory in Batumi" in your F10 menu, flag 12 will be set as true and the F10 menu will close.  You can do whatever you like with the flag in the mission editor.
--You can also do trigger.action.setUserFlag(12, 15) if you want to set flag 12 to a value of 15.

--Ok, last but not least, the whole purpose of this advanced tutorial was to learn how to REMOVE items from the F10 menu.
--This is really simple.  It requires another line of code.  You can enter the code into a lua script file, however...
--...I find it easier to just insert this line of code (which you'll soon learn below) directly into the mission editor.
--Let's go back to our example and pretend we flew the mission and have destroyed the factory in Batumi and DCS somehow managed to survive without crashing due to some new bug...
--In the mission editior, you'll want to create a new trigger, type "ONCE", condition set to detect the factory is destroyed, and then for the actions choose "DO SCRIPT"
--In the text box for "DO SCRIPT" place this line of code:

missionCommands.removeItem(GroundObjectivesSubMenu[1])

--That's it!  You can even remove the entire list of ground objectives with:

missionCommands.removeItem(ObjectivesSubMenu[2])

--Now if you go back to your F10 menu --> Remaining Objectives --> Ground Objectives, and now you'll see only 3 remaining objectives as the Factory objective has been removed.

--Hope you enjoyed!
--Cheers,
--GT, out!


--But wait!  Don't go yet.  That was a lot of stuff above and might scare you. It was all comments though! 
--Look below at what it looks like with all the comments removed AND I even added a few more F10 menu items.  See how short it is?
--One more quick exercise to show you how simple it is to build a menu:
--1. Save this script file as some other name so that you don't overwrite this one.
--2. Open up any mission inside Mission Editor or create a new one.
--3. Create a new trigger, at MISSION START, or have it execute after time more than 5 seconds (or whatever).  Action will be DO SCRIPT FILE.
--4. For DO SCRIPT FILE. Navigate to, and load this new file you just saved (but only after you complete the following steps).
------IMPORTANT: Whenever you are working on your own script and make a change to it, you MUST repeat Step 4 to reload the new file into the .miz. 
--5. Run the mission and play with the F10 menu while you look at this script on another monitor so you can see and learn how it works in action. Note the different order and formatting of the lines for clarity.
--6. Now you should be looking at the new file you just saved as in step 1.  
--7. Go ahead and delete this line and EVERYTHING above it.  Only the stuff below here should remain. Save and continue as mentioned in step 4 above. Good luck!

local FirstItemMenu = missionCommands.addSubMenu("Flag 1 Control", nil)
    missionCommands.addCommand("Set flag 1 true", FirstItemMenu, function() trigger.action.setUserFlag(1, true) end, nil)
    missionCommands.addCommand("Set flag 1 false", FirstItemMenu, function() trigger.action.setUserFlag(1, false) end, nil)

local SecondItemMenu = missionCommands.addSubMenu("Tell Me a Joke", nil)
    missionCommands.addCommand("Joke 1", SecondItemMenu, function() trigger.action.outText("DCS is bug-free!", 15, false) end, nil)
    missionCommands.addCommand("Joke 2", SecondItemMenu, function() trigger.action.outText("I prefer Farming Simulator over DCS", 15, false) end, nil)

local ThirdItemMenu = missionCommands.addSubMenu("Remaining Objectives...", nil)
    local ObjectivesSubMenu = {}

    ObjectivesSubMenu[1] = missionCommands.addSubMenu("Air Objectives", ThirdItemMenu)
        AirObjectivesSubMenu = {}
        AirObjectivesSubMenu[1] = missionCommands.addCommand("Take out Su-27s",              ObjectivesSubMenu[1], function() trigger.action.outText("Enemy fighters are over the dam.", 15, false) end, nil)
        AirObjectivesSubMenu[2] = missionCommands.addCommand("Take out enemy bomber",        ObjectivesSubMenu[1], function() end, nil) -- since there is nothing contained in the function, nothing will happen.
        AirObjectivesSubMenu[3] = missionCommands.addCommand("Take out enemy AWACS",         ObjectivesSubMenu[1], function() end, nil)
        AirObjectivesSubMenu[4] = missionCommands.addCommand("Take out enemy tanker",        ObjectivesSubMenu[1], function() end, nil)
        AirObjectivesSubMenu[5] = missionCommands.addCommand("Remove this option from list", ObjectivesSubMenu[1], function() missionCommands.removeItem(AirObjectivesSubMenu[5]) end, nil)

    ObjectivesSubMenu[2] = missionCommands.addSubMenu("Ground Objectives", ThirdItemMenu)
        GroundObjectivesSubMenu = {}
        GroundObjectivesSubMenu[1] = missionCommands.addCommand("Destroy factory in Batumi",          ObjectivesSubMenu[2], function() trigger.action.outText("Factory is located in Grid 37TMN123456", 15, false) end, nil)
        GroundObjectivesSubMenu[2] = missionCommands.addCommand("Eliminate SA-10 near Kobuleti",      ObjectivesSubMenu[2], function() end, nil)
        GroundObjectivesSubMenu[3] = missionCommands.addCommand("Eliminate T-72 column",              ObjectivesSubMenu[2], function() end, nil)
        GroundObjectivesSubMenu[4] = missionCommands.addCommand("Sink enemy submarine",               ObjectivesSubMenu[2], function() end, nil)
        GroundObjectivesSubMenu[5] = missionCommands.addCommand("Remove entire list of ground objs.", ObjectivesSubMenu[2], function() missionCommands.removeItem(ObjectivesSubMenu[2]) end, nil)

