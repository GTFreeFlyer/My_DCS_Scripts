--Copywrite 2020.  "GTFreeFlyer"
--This tutorial is free to distribute.  It may not be altered, sold, or used for revenue generation without written permission from GTFreeFlyer.  Contact GTFreeFlyer@yahoo.com.
--Use of any poriton of this tutorial requires proper credit given.  i.e. "Example copied from GTFreeFlyer's tutorials."  The credit must include a link to where others can find the tutorials.
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--Welcome back.
--We need to take a break from actual DCS examples for a moment (I'm so sorry!  I really am.) because this next topic we're about to learn is extemely important and useful...  
--That would be the topic of tables.
--In fact, if you skip this tables tutorial, I'll save you the time and just tell you to skip all remaining tutorials of mine altogether because you'll be lost.
--Tables are so widely used in programming that they deserve their own tutorial.
--Don't worry, what you learn here will apply directly to DCS scripting because tables are widely used within DCS.
--In fact, you'll be lost trying to understand some of the built-in DCS functions & commands if you don't have a grasp on tables.
--What you'll learn here will apply directly to DCS scripting, and we're goig to have fun doing it by referencing and giving examples related to DCS.
--Again, pay attention, tables are freakin' awesome and I'm going to make this very easy for you - yes, you - to understand tables in a fun way.
--Now imagine that I've just slapped you across the face.  You are now awake enough to continue.  Here we go....

--So what is a "table" when it comes to Lua?
--Well, imagine you are working with a Microsoft Excel spreadsheet and orgainzing your data into rows and columns.  Yeah, let's go ahead and think of it like that: A table is a spreadsheet.
--Why would you want to use tables?  Because they are great and efficient ways of storing lots of data that will be easy to find and call later on.
--One example would be to store a list of all players names, and for each player you can also store info like callsign, location, altitude, score, fuel remaining, etc. etc.
--See?  Sounds like an Excel spreadsheet already, right?
--Tables are not a flat surface for your dinner plates, so stop thinking about food.  Mmm... did someone say food?
--Okay, enough talk, let's just get right into it and work slowly from there.

GTFreeFlyers_Table = {}

--Congrats, we just created our first table.
--See what I did there?  I created a new table called GTFreeFlyers_Table.
--How do you know it's a table?  Well, because Lua tables are always contained within braces {}.  I created an empty table.  
--This is equivalent to opening up a blank Excel spreadsheet and saving the file as GTFreeFlyers_Table.xls.  The spreadsheet has a name, but no data in it.  
--All those blank cells in your spreadsheet are organized into rows and columns, and this is known as the table.
--See, you're already getting it.  I told you this was going to be easy for you, so stop doubting yourself. 
--There are two types of tables that can be created. 1) Index-value tables and 2) Key-value tables.  We'll start with the easier one: Index-value tables in this tutorial.
--The next tutorial will discuss the key-value table, so just ignore the fact that I even mentioned two types of tables for now.

--Now let's type some stuff into those blank cells in our Excel spreadsheet...

GTFreeFlyers_Table = {"Pilot1", "Pilot2", "Pilot3"}

--Note, you can also put items on separate lines to make it easier to read if your table gets very big.  It's up to you to choose how you prefer to see it displayed:

GTFreeFlyers_Table = {
    "Pilot1", 
    "Pilot2",
    "Pilot3"
}

--Hey, wait!  I've played around with CTLD, MIST and Moose and other DCS scripts and that format looks familiar!
--You're damn right it looks familiar!  Tables are extremely useful and everyone uses them.  So stay awake and pay attention to the remainder of this tutorial.

--Alright, we now created a table with three entires.  Each entry is a string such as, "Pilot1", etc.  
--What's a string?  Well, it's not a number or variable.  It is simply text.
--Strings must be contained within "quotes" or 'quotes' so that Lua knows it is a string, and not a variable.
--If you wrote something like MyCallsign = "GTFreeFlyer", then you could tell Lua to print(MyCallsign) and it would spit out GTFreeFlyer.
--However, if you wrote something like MyCallsign = GTFreeFlyer, note I'm not using quotes, then you'd get an error because GTFreeFlyer is a variable, not a string, and it is undefined (nothing stored in it).
--If I had first specified GTFreeFlyer = "Great Tutorials" ...
--...then wrote MyCallsign = GTFreeFlyer ...
--...then print(MyCallsign) would spit out Great Tutorials.  Got it?  Good.  Let's move on, back to tables.

--So we have a table called GTFreeFlyers_Table and it has three entries.  Think of it like your spreadsheet and each entry is in column A, and in rows 1, 2, and 3 down the left side of the table.
--Each entry is in an "indexed" location.  That is, they each have an index position where they are located.  This would be your row number in a spreadsheet.
--As you may have guessed, they are in index positions 1, 2, and 3.
--Yup, each index has a value assigned to it.  In this case each value is really a string, but for the sake of tables, they are values.  Whatever is inside your spreadsheet's cell is a "value".
--Wait what?  Oh now I get it!  "Index-value tables"!  That's why they are called that!

--So what do we do with the indexes?  We can easily retrieve data from these indexes.  Watch this...

print(GTFreeFlyers_Table[1])
--This will spit out Pilot1 in a Lua script.
--However, note that the print() command won't be used with DCS scripting because we have nowhere to print to.
--In DCS, it would be more common to print stuff to your DCS.log file so you can see what your code is doing if it decides to crash.  This is called debugging, which we'll cover in detail in another tutorial.
--However, to keep it simple you would simply write...

env.info(GTFreeFlyers_Table[1])

--... anywhere in your code and it will cause Pilot1 to appear in your DCS.log file.  Or...

trigger.action.outText(GTFreeFlyers_Table[1], 15)

--... will display the text, Pilot1, for 15 seconds in the upper-right of your DCS window while you are flying.  This is how you can alert pilots to a certain objective or whatever message you need them to see. 
-- You can even do math inside the brackets...

env.info( GTFreeFlyers_Table[7000-6998+1] )  --That equals 3 for you dummies, and will spit out Pilot3 into you DCS.log file.

--Both trigger.action.outText() and env.info() are DCS functions that only DCS understands.  You wouldn't use these functions in other Lua scripts for other games/programs.

--Okay, so now we learned that index positions are contained within [square brackets], while all contents of a table are contained within {braces}.  This is important to remember.
--Index-value tables are great because we can quickly look for data... if we know where it is stored.  
--Index values must be integers (1, 2, 3, etc).
--You don't have to use consectutive numbers, but it is best to if you can.
--For example, we can add a 4th item to our table, and let's go ahead and add it to index position 8.

GTFreeFlyers_Table[8] = "Pilot8"

--That's all it takes to add an item to your table.
--Now if we ask for GTFreeFlyers_Table[4], we will get nil, because this 4th item we added is not in the 4th index position.  We stuck it in position 8.
--What's nil?  Nil is nothing, quite literally.  It is not zero, it is just an empty black hole of nothingness...  
--... No, it's not actually that, because that is something of itself.  It's blank, nada, get it?  You can't do jack sh*t with it.
--If we printed our table now it would look like this:

{"Pilot1", "Pilot2", "Pilot3", nil, nil, nil, nil, "Pilot8"}

--Alright, now take a quick break and go to this website:
https://repl.it/languages/lua
--Bookmark it and use it often to test your ideas.  It is an online Lua interpreter.  It can execute Lua scripts on the fly.  
--You'll learn soooo much just by playing around with it and trying things out on your own.
--Go ahead, open up that webpage and paste the following chunk of familiar-looking code into the typing area...

GTFreeFlyers_Table = {"Pilot1", "Pilot2", "Pilot3"}
GTFreeFlyers_Table[8] = "Pilot8"
for index = 1, 8 do
    print(GTFreeFlyers_Table[index])
end

--.. and now click "Run"
--Cool, eh?
--Since this tutorial is simply related to Tables, we're not going to learn about for-loops right now, but I think you can figure that one out on your own.  We'll definitely learn for-loops in an upcoming tutorial.
--However, I'll simply mention that the "for" line is read like this:  "For a new variable named index, which starts at 1 and goes until 8, do the following lines of code"
--As you can see, we had to know that there are 8 items in the table to look for.  We don't always know the size of a table, as later on you'll be dynamically adding and removing items from the table and size will always be changing.

--Ok, now one really useful table command involves the hash tag #.
--If you place the hash tag (or perhaps you prefer pound sign if you are older like me) in front of the name of the table, it simply returns the number of items inside the table.

GTFreeFlyers_Table = {"Pilot1", "Pilot2", "Pilot3"}
print(#GTFreeFlyers_Table)

--Go ahead, try that one in the online interpreter.  Okay lazy bum, I'll save you time.  It simply prints out the number 3.
--So if you don't know how big the table is, then you would write your for-loop like this:

GTFreeFlyers_Table = {"Pilot1", "Pilot2", "Pilot3"}
for index = 1, #GTFreeFlyers_Table do
    print(GTFreeFlyers_Table[index])
end

--That would the the same as writing for index = 1, 3, because 3 items were counted inside the table.
--Now try this one...

GTFreeFlyers_Table = {"Pilot1", "Pilot2", "Pilot3"}
GTFreeFlyers_Table[8] = "Pilot8"
print(#GTFreeFlyers_Table)

--Holy balls!  Why is it telling me 3 again?  There are 8 items in the table!
--Well, remember that nil is not an item.  It doesn't exist.
--When Lua starts counting items in a table, it will start at index 1 and go until it hits a nil.  Otherwise, it would keep counting forever and ever and ever and, well you get the point.
--This is why I mentioned earlier that you might want to use consectutive index numbers if able.

--Alright.  Let's take it further.  Values inside the table don't have to be strings like in the examples above.  They could also be numbers, or variables, or get this... more tables!
--Example: Let's pretend we want to store a pilot's name, his tail number, and his x,y,z location:

PilotInfo = {"GTFreeFlyer", 101, {12345, -54321, 98765}}

--You can see that the third index is another table.

print(PilotInfo[3])  --this command will return some gibberish to you, because tables don't print nicely.  They are stored as some sort of code.
print(PilotInfo[3][2]) --this will give you -54321.  Get it?  First we look up index 3 in the PilotInfo table, which will gives us another table, and then we look up index 2 in that table.

--Using this method requires that you always remember that tail number is in index 2, and so forth.  That is true only if items in your table stay where they should.
--There is another method and we will learn it in the next tutorial, Key-Value tables.  
--Instead of using index numbers within a table to store values, we will use "keys" to store values.  Keys are simply words, or "strings" as you now know them.
--We will eventually learn to do something like:

print(PilotInfo.tailNumber) 

--...and this makes a lot more sense than having to remember which index number contains your tail number.
--Don't worry about it now, we'll get to it later, but I just wanted you to know about it.

--Okay, congrats!  You have now learned the basics to the Index-Value tables.
--However, there are some more functions that are very useful when working with Index-Value tables and I'm going to show you a few examples.
--In order to prevent your delicate brain from being overloaded, I'll skip on the details for the remaining functions, because I know your brain would rather save space for learning the A-10C Warthog.
--They are pretty self-explanatory, and you will benefit most from just going back to the online interpreter (https://repl.it/languages/lua) and playing around with them.
--I'll just give you the quick run-down of the popular ones.  You can always Google search "Lua table commands" to learn more on your own.

--Let's go back and start with our previous example:
GTFreeFlyers_Table = {"Pilot1", "Pilot2", "Pilot3"}

--Inserting values into a table:
table.insert(GTFreeFlyers_Table, "Pilot4")  --this will insert Pilot4 at the FIRST AVAILABLE empty index position.  In this case it will go into index 4.
table.insert(GTFreeFlyers_Table, 5, "Pilot5")  --this will insert Pilot5 at the specific index you specify, in this case index 5.  Also equivalent to GTFreeFlyers_Table[5] = "Pilot5"
table.insert(GTFreeFlyers_Table, #GTFreeFlyers_Table + 1, "Pilot6") --Remember, #GTFreeFlyers_Table will count the values in a table, in this case we have 5 from before, so we say +1 to increment to the next index.

--Removing values from a table:
table.remove(GTFreeFlyers_Table, #GTFreeFlyers_Table) --removes the last entry from a table.

--Continuing from the orginal table, as if we ran all these lines consecutively, we should now have indexes 1 through 5 filled.
table.remove(GTFreeFlyers_Table, 2) --removes the value from index 2.

--IMPORTANT!!!  Running the line above will delete the value from index 2, and cause everything to the right of it to shift one space to the left.
--Now your table looks like this:  {"Pilot1", "Pilot3", "Pilot4"}
--And now you no longer know where values are stored unless you are good at keeping track.
--If you wanted them to stay in place, you could have done this instead:

GTFreeFlyers_Table[2] = nil
--Now your table looks like this:  {"Pilot1", nil, "Pilot3", "Pilot4"} and all your stuff stays where you last left it.

--Okay, that's it.  We'll see later how DCS uses tables pretty much everywhere.  See you next time!
--Cheers,
--GT, out!