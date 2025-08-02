--Copywrite 2020.  "GTFreeFlyer"
--This tutorial is free to distribute.  It may not be altered, sold, or used for revenue generation without written permission from GTFreeFlyer.  Contact GTFreeFlyer@yahoo.com.
--Use of any poriton of this tutorial requires proper credit given.  i.e. "Example copied from GTFreeFlyer's tutorials."  The credit must include a link to where others can find the tutorials.
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--Welcome back.  GTFreeFlyer here again.
--We are now continuing from where we left off in the Index-Value Tables tutorial.
--If you have not yet gone through the Index-Value Tables tutorial, stop right now and go back to it, otherwise you may be lost in this tutorial.

--Once again, let's go ahead and open up the online Lua interpreter in a web browser so we can play with it during this tutorial.
--Here's the link:  https://repl.it/languages/lua

--Alright, let's just refresh our memory for a second here...
--The Index-Value tables are tables which have "values" stored in specific locations within the table.  These locations are called indexes.

MyExampleTable = {"Value 1", "Value 2", "Value 3"}

--Each value above is stored in either index 1, 2 or 3 as you see.
--You would call up the index by placing its number within square brackets [].  Example...

retrievedDataFromFirstIndex = MyExampleTable[1]

--Okay, good.  I hope you have refreshed your memory now.  Let's now move on to Key-Value tables.
--Don't get too worried.  As you see, there is only one difference between Index-Value tables and Key-Value tables.
--What, you don't see the difference?  Values are still values, but we will now be using Keys instead of Indexes.  That's it!
--What's a key?  A key is simply not a numbered index.
--You can assign a specific word (or in programming we call this a string), to the index.
--Keys don't really have a location inside the table.  Well, technically they do, but we will never need to know where inside the table they are.
--Keys are just somewhere inside the table, and their specific location does not matter to us.

--Ok, quick example:

GTsNewTable = {name = "GTFreeFlyer", tutorialDifficuly = "Very simple", myFavoriteNumber = 99}

--Look at the example and see that there are three entries in the table.  Each one is separated by a comma.
--The first entry has a value, which is a string, GTFreeFlyer.  You know it is a string because it is in quotes.
--The third entry has a value, which is just a number, 99.

--Now here's something that may be confusing at first:
GTsNewTable[1] --will return nil.
--Why is it nil?  I can see right up there that there is obviously something in the first index!
--Ah ha!  Stop thinking like that.  That was the "old" index-value way of thinking.
--Because we specified name = "GTFreeFlyer", the value of "GTFreeFlyer" is stored in a key named, well... name.
--This key, and all three keys in the example, are just simply "dropped" somewhere into a black hole inside the table.  We don't know where they are insdie the table, but they are there.
--In fact, we can mix indexes and keys together.

GTsNewTable = {name = "GTFreeFlyer", tutorialDifficuly = "Very simple", myFavoriteNumber = 99}
GTsNewTable[1] = "myFirstValue"

--Now we have a table with four entries.  One of them can be found in the first index location, and its value is "myFirstValue".
--The other three entries are stored in the table with their keys.

--Okay, now it is important to know that all keys (such as name, tutorialDifficuly, and myFavoriteNumber in our example) are assumed to be strings.
--Read that last line above again, and again.  This leads to lots of confusion sometimes, because they are not inside quotes, and they look like variables.
--Again, keys are already assumed to be strings and DO NOT need quotes.
--If we forced them to be strings, such as...

GTsNewTable = {"name" = "GTFreeFlyer"}

--...then you'll likely get errors.  Just leave the quotes off of the keys.
--Okay, now we have no idea where inside the table these keys are stored, so how do we call them up?
--Very simple!  Just like an index!

print(GTsNewTable["name"]) -- will print GTFreeFlyer
print(GTsNewTable["tutorialDifficuly"]) -- will print Very simple
print(GTsNewTable["myFavoriteNumber"]) -- will print 99.

--IMPORTANT! Look inside those square brackets [].  You see how we had to put the quotes on the keys?  That's because keys are strings.
--You may not have to use the quotes when defining a key, because it is already assumed to be a string, but you must use the quotes when calling them up.
--If we didn't use quotes, Lua would think you are trying to call up a variable.

print(GTsNewTable[name]) -- will return nil, because name is a variable (it doesn't have quotes), and nothing is stored in it.

--Just to try and confuse you, I can do this:

name = 1
print(GTsNewTable["name"]) -- will print GTFreeFlyer
print(GTsNewTable[name]) -- will print myFirstValue

--See? The string, "name", is referring to an index.
--The variable, name, has been set equal to 1. GTsNewTable[name] is now the same thing as GTsNewTable[1], and remember above we stored a value in index location 1?  There ya go!

--Alright, why in the world would we want to use keys instead of indexes?
--Well, if you remeber from the last tutorial, values inside an index-value table might shift around if values are constantly being added or removed.
--For example, if you stored a pilot's name in index location 1 inside a table, it might not always be in that location depending on what you are doing with your code.
--However, if you stored the pilot's name using a key, just like we did in the example above, it will ALWAYS remain there.... and the funny thing is that we don't even know where "there" is.
--It is also much more intutive to look for a pilot's name using GTsNewTable["name"] rather than GTsNewTable[1].  You'll know exactly what you are getting.

--Ok, glad your fragile little brain is getting the hang of this.  Now let's look at something else...
--Most people won't write out GTsNewTable["name"].
--Instead, you'll see GTsNewTable.name
--Both of these are equivalent, althought the second one is quicker to type out and looks a little cleaner in your code.
--Using the "dot", indicates that you are calling up a key, not an index.  It will only work with keys, and not with indexes.
--Because it only works with keys, yup, you guessed it!  It assumes that what follows the dot is a string.  You don't have to use quotes!
--Go ahead, try GTsNewTable."name" and you'll get an error.  Lua is pretty much telling you it hates you for assuming it is stupid.  It already knows the key is a string and doesn't want you to remind it.

--Spend a few minutes now with the online interpreter and just make your own examples and try to play with indexes, keys, strings, values, variables, dot, no dot.  You'll learn a ton.
--Start by copying and pasting our following example, then just tweaking it on your own.

GTsNewTable = {name = "GTFreeFlyer", tutorialDifficuly = "Very simple", myFavoriteNumber = 99}
GTsNewTable[1] = "myFirstValue"
GTsNewTable[3] = "myThirdValue"
indexLocation = 1
print(GTsNewTable.name)
print(GTsNewTable["name"])
print(GTsNewTable.mySocialSecurityNumber)
print(GTsNewTable.myFavoriteNumber)
print(GTsNewTable[1])
print(GTsNewTable[2])
print(GTsNewTable[3])
myNewFavoriteNumber = GTsNewTable.myFavoriteNumber - 30 -- let's define a new variable here and pick a new favorite number
GTsNewTable.myFavoriteNumber = myNewFavoriteNumber -- let's overwrite the old favorite number with our new favorite number
print(GTsNewTable.myFavoriteNumber)

--Go ahead and run this example in the online Lua interpreter, and just look at it line by line and compare with what is printed out.  It should be pretty simple to understand.

--If you want to remove a key from a table, you would simply set its value to nil.
GTsNewTable.name = nil
--And that's it.  My name has now been wiped out from existence :(

--Now let's look at a real example that you may already be familiar with:  
--Perhaps you've heard of the CTLD script if you've been around DCS long enough?
--The VERY FIRST line of code in CTLD is this...

ctld = {}

--Holy crap! CTLD is a table?
--Yup, it sure is.  The script starts off by defining CTLD as an empty table, then that table gets built one piece at a time as you continue to read through the script.
--The script continues into the first section of the code with parameters that the user can set to tweak certain things the way he'd like it for his mission.  Check it out...
--But first, I cannot take credit for CTLD.  Ciribob is the one who deserves all the credit (and anyone else that he may have worked with).  
--I am simply using a few lines from CTLD as an example so you can see how tables are used within DCS...

ctld.maxExtractDistance = 125 -- max distance from vehicle to troops to allow a group extraction
ctld.vehiclesForTransportBLUE = { "M1045 HMMWV TOW", "M1043 HMMWV Armament" } -- vehicles to load onto c130 - Alternatives {"M1128 Stryker MGS","M1097 Avenger"}
ctld.buildTimeFOB = 120 --time in seconds for the FOB to be built
ctld.radioSound = "beacon.ogg" -- the name of the sound file to use for the FOB radio beacons. If this isnt added to the mission BEACONS WONT WORK!
ctld.enabledRadioBeaconDrop = true -- if its set to false then beacons cannot be dropped by units

--If you've looked at CTLD in the past and been lost, I bet you are feeling more comforatble with it now :)
--You can see how things are stored in the CTLD table.  They are using keys!
--Later in the code, when using these values for calculations, you can simply call up ctld.buildTimeFOB and you'll know exactly what it is!
--If CTLD was an index-value table, it might end up containing several hundred different indexes.
--Let's pretend that this ficticious index-value table will never have its values move around and that your buildTimeFOB value was stored in index location 147.
--Well now you have to remember that ctld[147] will give you what you are looking for.  This is tedious and you'd have to have a separate sheet or notebook to keep track of all this.
--Ridiculous I say!
--I don't need to convice you any further that ctld.buildTimeFOB is much simpler.  You know what it is just by simply looking at it!

--Ok that covers up the basics of the Key-Value tables.  That wasn't too bad was it?  Ok good!  I want to keep filling up your brain with good stuff, so now a REAL DCS example:

--Let's look at another example of a Key-Value table, one that you might use A LOT when scripting in DCS.
--This example would be the vec3.

--What's a vec3?  Well, it's just a name that DCS uses to describe a table containing positional information, and it has a specific format.  
--The vec3 is simply a three point vector (AKA 3D space coordinate with x, y and z values)
--First, let's take a look at a DCS function you might end up using.
--Go ahead and open this page up: https://wiki.hoggitworld.com/view/DCS_func_getZone
--This is the function that you would use to get information about a trigger zone in the editor.

--Let's look at the syntax, but first what is syntax?  Don't confuse yourself too much.  Syntax is the same thing as grammar.
--Just like in any spoken language, grammar would be the rules you follow to construct sentences.  Certain words come before other words, etc.  Also using punctuation marks, etc.
--Yoda obviously failed his grammar course.  Say you, right I am?
--We don't talk about grammar in programming, instead we talk about syntax.  It's the same thing, just a different word, so don't let it throw you off.

--Ok, the syntax for this function is:

table trigger.misc.getZone(string zoneName )

--Now here in this editor you are using to read this tutorial, the colors of each of those words don't match what you see on the web page.
--I'm going to talk about the colors as you see them on the webpage, so make sure you are looking at that.

--First, we see "table" written out in orange.  When you run this function, it will spit something out at you.  What format will it be?  A number? A string? No!, orange tells you it will be a table!
--Next, we see trigger.misc.getZone(string zoneName )
--"string" is in bold, which just means it is describing what format it wants "zoneName" to be.
--So really, the function you would enter into your script would be something like:

trigger.misc.getZone("Dogfighting Area") -- assuming you have a trigger zone in your mission called Dogfighting Area.

--That's it, you would type that line, just as you see it there, into your lua script and it will return a table.  What will this table look like?  Well, check out the example on the webpage:

{point = Vec3, radius = Distance} -- is what will be returned after running that function.

--aaaaannnndddd that brings us right back to our Key-Value table discussion.
--We see a table with two entires:  1. Some value called a vec3 stored in the key "point", and a value called Distance stored in the key "radius".
--It isn't clear on that specific webpage, but I'll tell you that Distance is a number in meters.
--It also isn't clear on that webpage what a vec3 is, but it is used in many DCS functions and if you Google "DCS vec3 format" you'll learn that a vec3 is a Key-Value table that looks like...

{x = Number, y = Number, z = Number}

--This usually refers to a specific x,y,z location on the map, and for a trigger zone it refers to the center of the circle.
--Now let's go back to our triggerzone function output:

{point = Vec3, radius = Distance} 

--is what you saw earlier, but it really looks like...

{
    point = {x = Number, y = Number, z = Number}, 
    radius = Distance
}

--Yup, a table within a table!  I broke it up into four separate lines for you to see it clearer, and you can actually write it out like this in your script if it is easier for you to see it this way.
--Now, without the "descriptive" info, an actual output you would expect is...

{
    point = {x = 345982, y = 0, z = -127563}, 
    radius = 9846
}

--So, if we wanted to do some sort of calculation with the x-coordinate of the trigger zone, let's say we wanted to double it for who-knows-what reason, we would do something like this:

ourTriggerZoneTable = {} -- defining a new empty table
ourTriggerZoneTable = trigger.misc.getZone("Dogfighting Area") -- remember that this function will return a table to you, so now ourTriggerZoneTable is actually a table with stuff inside it.
ourXcoordinate = ourTriggerZoneTable.point.x  -- Did you like that?  First, we call the key "point" which gives us another Key-Value table, and then we call the key "x".
ourNewXcoordinate = Xcoordinate * 2 -- and now we've doubled it!  If you want to stick in back into the table, simply type...
ourTriggerZoneTable.point.x = ourNewXcoordinate

--and now our table looks like this:

{
    point = {x = 691964, y = 0, z = -127563}, 
    radius = 9846
}

--I'm pretty much done here, but I'll just give you a more useful example which I know you'll come back to look at and use in the future:
--It's often common to want to know if a specific unit is inside a trigger zone.
--I'm not going to throw another DCS function at you at this time, but pretend you got the vec3 for Pilot1 and it is:

Pilot1Location = {x = 345000, y = 100, z = -127000}

--... and our previous triggerzone is still.... 

ourTriggerZoneTable = 
{
    point = {x = 345982, y = 129.45, z = -127563}, 
    radius = 9846
}

--Let's ignore altitude, which is the y-coordinate in DCS's coordinate system.
--The math formula for distance between two points is (I'm so sorry for bringing back these terrible memories) is Distance = The square root of (x2-x1)^2 + (y2-y1)^2.
--Here, our z-coordinate is really like our y-coordinate for the sake of that math equation, so Distance along the ground in DCS = The square root of (x2-x1)^2 + (z2-z1)^2.

--Now let's figure out if Pilot1 is within the trigger zone:

distanceZoneToPilot1 = math.sqrt((ourTriggerZoneTable.point.x - Pilot1Location.x)^2 + (ourTriggerZoneTable.point.z - Pilot1Location.z)^2)

--If we do the math, we find that distanceZoneToPilot1 = 1131.942
--Now we need to check if we are inside the trigger zone:

if distanceZoneToPilot1 < ourTriggerZoneTable.radius then  --if distance is less than the radius of the zone
    trigger.action.setUserFlag("1", true)  --let's set a flag to true
else                                       -- if the condition is not true, i.e. if distanceZoneToPilot1 >= ourTriggerZoneTable.radius.   >= is read as "greater than or equal to"
    trigger.action.setUserFlag("1", false)  --let's set the falg to false
end
    
--What I've done here is set the mission editor flag number 1 to true or false based on whether or not Pilot1 is inside the trigger zone.
--The function I used for setting the flag can be found here:  https://wiki.hoggitworld.com/view/DCS_func_setUserFlag
--I encourage you to look at it in detail until you understand it.  You'll see that the function does not return a table like our previous example, but that it returns another function.
--Confused?  Don't be.  It is just returning a function that you don't have to do anything with.  When you run trigger.action.setUserFlag, it returns a function that self-executes and sets the flag value for you.
--Don't get too hung up here if it is your first time looking at this stuff.  Just remeber that the tutorial is meant to get your familiar with Key-Value tables.
--I just threw out some additional examples at the end here for those of you that catch on quickly and wanted to see a real example of something you'll probably end up using.

--Ok, I'm done for now.  How are you you doing?  Did you survive?  Need a hug?  Sorry, those are not included with my tutorials.

--Catch you next time!
--Cheers,
--GT, out!