--Copywrite 2020.  "GTFreeFlyer"
--This tutorial is free to distribute.  It may not be altered, sold, or used for revenue generation without written permission from GTFreeFlyer.  Contact GTFreeFlyer@yahoo.com.
--Use of any poriton of this tutorial requires proper credit given.  i.e. "Example copied from GTFreeFlyer's tutorials."  The credit must include a link to where others can find the tutorials.
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--Hi there again.  GT here, but you already knew that!
--We now need to hop back to the subject of tables.  I wasn't finished with them yet, but we had to learn about loops before continuing.
--So, welcome back to the third tutorial about tables.  This one will be quick!

--We already learned how to put values into tables, either in indexes or with keys, so we won't relearn that.
--We also learned how to pull specific values out of the table, if we knew where inside the table they were.
--However, we did not discuss how to quickly search through the ENTIRE table.
--That's what we'll do now.

--We'll begin with a table called... hmmm... how about table?

table = {}
table[1] = 10
table[7] = 70
table[2] = 20
table[95] = 950
table[3] = 30
table[5] = nil

--You can see I stuck a few values in random index locations.  For simplicity, I just made the values 10 times larger than their index value.
--If you recall from the index-value tutorial, we tried something like this:

for index = 1, #table do  --"for index 1 to highest index number do"
  print(table[index])
end

--This is an example where we don't know how large the table is.  We don't know how many indexes are in there.
--Buy running this code, we find out there are only three values stored in the table.  This is because once we check index number 4, we get a nil and the whole process stops.
--Not ideal at all, because we have more crap in our table that we completely missed!
--If we had an idea about the size of our table, perhaps 100 indexes, we could do...

for index = 1, 100 do  --"for index 1 to 100 do"
  print(table[index])
end

--...but then we'd get a whole bunch of nils returned to us and we have to go through the whole list of 100 items and figure out which entries are not nil.
--Go ahead and try those examples in the online Lua complier... https://repl.it/languages/lua

--Ok, THERE IS ANOTHER WAY!  That is what we are learning about in this tutorial.
--We'll learn how to use pairs and ipairs.
--These are two Lua commands that are used to search through tables.
--Let's start again with something simple:

table = {10, 20, 30}

--Three values in index locations 1 through 3.
--Let's learn about ipairs real quick.  Watch this:

for index, value in ipairs(table) do
  print("index " .. index .. ": value = " .. value)
end

--Again, try it in the online Lua complier... https://repl.it/languages/lua

--Alright, let's break it down as we always do...
--First, you see we are running a For-Loop, which we learned about in the previous tutorial so we won't go into that again.
--Next, we see something new:  index, value in ipairs(table)
--We created two new variables, index and value.  We could have named these anything we wanted, but these are the names I usually choose when searching index-value because it makes sense to me.
--We also see a function, ipairs(table).  This is telling the loop that we will be searching a table named table using the ipairs method.  
--The other option is to search the table using the pairs method.  We'll see that later.

--When we specify "index, value in ipairs(table)", what is happening is this:
--Lua will go thru the entire table, in numerical order of the indexes and will loop because we are inside a For-Loop.
--Each time around the loop, two new vairables will be set:
------1: index will be set to the current index number being called up
------2: value will be set to the current value of that index number
--That's it.  Make sure to run the example in the online interpreter to see it in action and boost your understanding.

--Alright, let's expand on this a little.  Let's throw something into index 99.

table = {10, 20, 30}
table[99] = 990
for index, value in ipairs(table) do
  print("index " .. index .. ": value = " .. value)
end

--What do we see now?
--The same thing!
--This is because ipairs wants to search the indexes in numerical order, and stops when reaching a nil.

--Now try changing ipairs to pairs.  (I hope you are still working with the online interpreter as we go thru these examples.)
table = {10, 20, 30}
table[99] = 990
for index, value in pairs(table) do
  print("index " .. index .. ": value = " .. value)
end

--Ah ha!  Now we got everything in the table, without all the nils in between indexes 3 and 99.
--Let's rewrite the same thing, but define the table slightly differently...

table= {}
table[99] = 990
table[2] = 20
table[48] = 480
table[49] = 490
table[32] = 320
table[17] = 170
table[80] = 800

for index, value in pairs(table) do
  print("index " .. index .. ": value = " .. value)
end

--What do you notice after running this?
--All values are pulled out of the table, but not in the same order we put them into the table.
--That's one of the main things about the pairs() function that you need to know:  The entire table will be searched, but THE ORDER IS NOT GAURANTEED!
--If you want to gaurantee the order in which values are returned to you, you must use the ipairs() function, not pairs().  
--However, you saw that ipairs()'s limitation was that it might not return everything in the table to you if it stumbles upon a nil while searching the table.
--Like everything with coding (and life), you need to decide which tool is appropriate for what you are trying to do with it.

--Alright, now moving on to Key-Value tables using an example that you might actually use one day...

playerStats= {}
playerStats[1] = "GTFreeFlyer"
playerStats.score = 99     -- Just a refresher, this is the same as playerStats["score"] = 99, or playerStats = {score = 99}
playerStats.type = "F/A-18C"
playerStats.positionX = 232556
playerStats.positionY = 1258
playerStats.positionZ = 369875
playerStats.Status = "on runway"

--And now let's try searching the table in numerical order using ipairs()

for stat, value in ipairs(playerStats) do
  print(stat .. ": " .. value)
end

--Hmm, all I see is "1: GTFreeFlyer"
--Where did everything else go?
--Well, I mixed indexes and keys in this table.
--Perhaps I meant to do this?  Perhaps I wanted the player's name to always be in index location 1?  That's just for this example.  In reality, I would totally use playerStats.name = "GTFreeFlyer" instead.
--Remember, ipairs() wants to start at index 1.  When it hits index 2 and sees nothing there, it stops.
--You can also see that the index location, "1", got pulled out and assigned to our first variable, stat.
--That first variable will always store either the index location, or the key assignment.
--That second variable will always store the value of the index or key.
--It's best to give these variables some name that makes sense to you.  
--Some coders will be lazy and write this: "for i, j in ipairs(playerStats) do".  i and j are variables which store the info the same as stat and value, but is more confusing in my opinion.
--Values stored in the table with keys do not have a location assigned to them.  They are just somewhere inside our "bucket" floating around in there.
--The only way to get them out is to know the key assigned to them, or to use a function such as pairs().

--Let's try the same thing but with pairs() this time...

for stat, value in pairs(playerStats) do
  print(stat .. ": " .. value)
end

--Nice!  We got EVERYTHING out of our table this time around.  We got indexes AND keys AND their values.
--Once again however, there is no order assigned, and we get all this "stuff" out of the table in whatever order Lua wants to give it to us in.

--That's all I got for ya.  
--Got it?  
--Now do good with it!

--Cheers,
--GT, out!