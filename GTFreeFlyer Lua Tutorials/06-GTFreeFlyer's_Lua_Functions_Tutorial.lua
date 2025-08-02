--Copywrite 2020.  "GTFreeFlyer"
--This tutorial is free to distribute.  It may not be altered, sold, or used for revenue generation without written permission from GTFreeFlyer.  Contact GTFreeFlyer@yahoo.com.
--Use of any poriton of this tutorial requires proper credit given.  i.e. "Example copied from GTFreeFlyer's tutorials."  The credit must include a link to where others can find the tutorials.
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--Hello there again!  GT here now going to give you a quick lesson in Lua functions.
--This should be a fairly quick topic to cover, and it is one of my favorite ones too.
--Functions are easy, and extremely useful.  This is a winning combination!

--So what's a function?
--Answer:  A function is something that does something.  Yeah, my 4-year-old could have come up with that answer, and he'd be correct.
--By now you should be familiar with the list of DCS functions.  If not, refresh your memory here: https://wiki.hoggitworld.com/view/Category:Functions
--Let's take a look at one of them.  I like explosions and things that go boom!  Don't you?

trigger.action.explosion(vec3, power)

--That's a DCS function right there.  See, it is something that does something.  Something cool!
--Let's ignore the contents inside the parenthesis for now.
--The name of this function is trigger.action.explosion, which is obviously some sort of key-index table built into DCS.  Confused?  Ah!  You skipped my key-index tutorial, didn't you, focker?
--We know it is a function because it is followed by parenthesis (), just like how we learned we can identify a table when we see braces {}.
--Again, we can identify we are looking at a function if we see those parenthesis () after the name of the function.

--So, our example above is called a function because it does something.
--When you want to use this function and execute it, we refer to this as "calling" the function.
--When you call this function in your script, it knows exactly what to do by running multiple lines of code in order to accomplish whatever it is that is needed to be done.
--In this case, these multiple lines of code are built into DCS and you don't have to worry about them.
--For example, without looking at those lines of code, we can probably guess that it involves producing some sort of visual effect, creating damage on an object, etc. etc.
--It might actually run several hundred lines of code.  Who knows?
--What would you rather do each time you wanted to create an explosion?  Would you rather type up several hundred lines of code EACH time you want to explode something?
--Heck no you wouldn't!  Don't waste your time with that crap.
--Instead, type up those hundreds of lines of code just once.  Then, define it as a function and give it a name.  
--Finally, use only ONE line of code for the remainder of your script each time you want to explode something again.
--This would be "efficient" code writing.  You never want to have to write the same piece of code twice.  Why?
--Well, because at some point you are going to want to change its behavior and then you'll have to make the change in multiple places throughout your script, and I'll bet money that you'll miss one of those places at least once.
--If you have your function defined in one place, such as this explosion, and then have 742 places in your script where you use the explosion, then suddenly want to change the behavior of the explosion...
--...you only have to make the change IN ONE PLACE in your script.  See?

--Ok, moving right along.  Let's create our own functon from scratch.  But first, we need an idea.
--Let's just keep it simple.  How about we just reset a bunch of flags in the mission back to a value of zero?  Let's call it resetFlags...

function resetFlags()
end

--And there we go.  It was that easy.  We just created a function named resetFlags.
--Note, we need the parenthesis () even if we aren't placing anything inside of them.  The stuff we place inside of them are called "arguments", but we'll get to that later; not now.
--Also note, we need an "end" to close out the definition of the function.

--Okay, we created a function and gave it a name, but it doesn't do anything.  You wouldn't actually type it as shown above, because it is pointless.  We need more lines!

function resetFlags()
    trigger.action.setUserFlag("1", 0)
    trigger.action.setUserFlag("2", 0)
    trigger.action.setUserFlag("3", 0)
    trigger.action.setUserFlag("4", 0)
end

--There we go, now that's a function that does something!  We used the DCS function trigger.action.setUserFlag() to set flag numbers 1 thru 4 to a value of 0. 
--Note that flag value of 0 is the same thing as flag is false, or flag is off, only in DCS.
--Also note that you DO NOT need to define an empty function before creating one.  I only showed the empty one as an example.  The following would be incorrect:

function resetFlags()
end

function resetFlags()
    trigger.action.setUserFlag("1", 0)
    trigger.action.setUserFlag("2", 0)
    trigger.action.setUserFlag("3", 0)
    trigger.action.setUserFlag("4", 0)
end

--Don't do this.  Just leave out the empty function.

--Nicely done!  Now how do we call this function?  How do we use it in our script?
--Like everything in my tutorials, it is simple!
--Simply write:

resetFlags()

--...anywhere in your script, and it will set flags 1 thru 4 to a value of zero!
--Example:

if playerIsDead == true then 
    resetFlags()
end

--Very well, let's move on now to passing "arguments" into a function.
--What's an argument?  Let's not fight about this, okay?  It's not a fight!  Just think of them as "things".  They can be valriables, strings, tables, etc.
--Here we go with another brand new fresh idea.  Let's make another function from scratch.
--Let's stick with flags, but this time we'll pass two arguments into our function.  
--We will pass two flag numbers into the function, and then we'll have the function compare the values of each flag, then return to us the higher value AND flag number which contains the higher value.
--Okay?  Here we go...

function compareFlags(firstFlagNumber, secondFlagNumber)
end

--Let's stop right here.  Just like last time, this is an empty function which you'll never use, but we'll leave it like this to explain what we've done.
--It looks similar to our first example, except we have stuck "stuff" inside the parenthesis.
--As you can see, this "stuff", called arguments, are the two flag numbers that we will pass down into this function for comparison.
--The two arguments, firstFlagNumber and secondFlagNumber, will become new variables that can be used inside the function.

--Alright, let's continue building our function together, one piece at a time...

function compareFlags(firstFlagNumber, secondFlagNumber)
    firstFlagValue = trigger.action.getUserFlag(firstFlagNumber)
    secondFlagValue = trigger.action.getUserFlag(secondFlagNumber)
end

--We created two new variables, firstFlagValue and secondFlagValue, and we used the built-in DCS function trigger.action.getUserFlag() to grab the values assigned to each of these flags.
--Now let's compare the two values...

function compareFlags(firstFlagNumber, secondFlagNumber)
    firstFlagValue = trigger.action.getUserFlag(firstFlagNumber)
    secondFlagValue = trigger.action.getUserFlag(secondFlagNumber)

    if firstFlagValue > secondFlagValue then      --First we will check if the first is larger than the second
        largestValue = firstFlagValue             --Here, we create a new variable named largestValue
        largestFlag = firstFlagNumber             --Let's do the same for the flag number itself
    elseif firstFlagValue < secondFlagValue then  --If the first condition isn't true, the script will evaluate this condition, is first value LESS than second value?
        largestValue = secondFlagValue            --If true, then we will set it.
        largestFlag = secondFlagNumber            --Also for the flag number
    else                                          --If neither of the two values above are true, then the only remaining possibility is that the two values are equal.
        largestValue = nil                        --We'll just set largestValue to be nil for now, if the values are equal, for no reason other than GT felt like being lazy.
    end
end

--Very good, now our function is fully defined and we can call it in a script like this:

compareFlags("3", "49")
env.info("Two flags compared.  Flag number " .. largestFlag .. " is the larger one with a value of " .. largestValue)

--So that's it.  I called the function, and passed two arguments, "3" and "49", both strings, down into the function.
--Why strings?  It doesn't have to be a string, but in our example a string is easier only because the DCS function trigger.action.getUserFlag() requires the argument to be a string.  See here:  https://wiki.hoggitworld.com/view/DCS_func_getUserFlag
--So we pass "3" and "49" down into the function, and they both get set as firstFlagNumber and secondFlagNumber, because that's what we defined as our two arguments when we defined the function.
--The next line, env.info(), is a DCS function that will print what you want into your DCS.log file so you can debug, or just see it for informational purposes.
--The argument for the env.info() function needs to be a string.  We can combine strings and numbers, variables, etc by "concatenating" them.  We do this in Lua with the double-dot.
--What you'll see in the DCS log will be "Two flags compared.  Flag number 3 is the larger one with a value of 2974".  Of course, only if Flag 3's value was actually 2974 in our mission.
--Now we can easily compare many different flags...

compareFlags("1", "2")
compareFlags("45", "12")
compareFlags("34", "9")

--See?  So much easier than writing out the code MANY, MANY times over and over again.

--Excellent, let's move on now to "returns"
--There is a command in Lua called "return", without the quotes.
--We stick this inside of functions when we want them to return something back to us.
--Need an example?  Go back and look at the getUserFlag() function here:  https://wiki.hoggitworld.com/view/DCS_func_getUserFlag
--You see how there is orange text that says "number".  This means that when you run the function, it will return a number to you.  Not a string, not a table, yes... a number.
--When we run getUserFlag(), it returns the value of the flag in the format of a number back to us.

--Alright, let's do a similar example that only compares numbers, not flags this time, and returns the larger number.


function findTheLargerNumber(firstNumber, secondNumber)
    if firstNumber > secondNumber then      --First we will check if the first is larger than the second
        return firstNumber                  --If true, we will return this number back to our main script.
    elseif firstNumber < secondNumber then  
        return secondNumber
    else                                     
        return nil                        
    end
end

--So, very similar to the previous example, but a little simpler since we are not checking flags.
--Any time you are running a function, and it comes across a "return" command, it will immediately stop doing anything else in the function and just return what you asked it to.

--So how does the return work?  If we type the following line of code:

findTheLargerNumber(3, 6)

--... it will return a number to you. It will return 6.
--You probably wouldn't use it by itself like this because that doesn't really do anything.  
-- That's the same thing as typing...

6

--...all by itself on a line.
--You might want to set a variable:

myFavoriteNumber = findTheLargerNumber(99, 2)

--You can even use it in a math equation:

myNewNumber = 4 + findTheLargerNumber(3, 10)

--myNewNumber would be equal to 14 in this case.
--Or even...

if findTheLargerNumber(3, 10) == 4 then   --Obviously this will never be true, but who cares?  This is only an example.
        --do something here
else
        --do something else here
end

--Ok, I'm done here and I think you get the point.
--One last thing before we go:

--Functions MUST be defined before you try to use them.
--Lua works from the top of the script towards the bottom.
--If you try this...

findTheLargerNumber(3, 6)

function findTheLargerNumber(firstNumber, secondNumber)
    if firstNumber > secondNumber then      --First we will check if the first is larger than the second
        return firstNumber                  --If true, we will return this number back to our main script.
    elseif firstNumber < secondNumber then  
        return secondNumber
    else                                     
        return nil                        
    end
end

--...you'll get an error.  You must make sure to stick "findTheLargerNumber(3, 6)" after the function is already defined.
--Whatever is inside the function won't actually execute until the function is called, so you can do whatever you want in there before the function is called.  
--Just make sure that whenever you call a function, Lua has already ran through and processed the definition of it.

--That's pretty much all I have to say about functions.  They can be as simple or as complicated as you'd like them to be.

--Now that you've gone thru this tutorial, you'll be able to recognize functions when seeing them, and you now know pretty much all there is to know about passing arguments into them.

--I hope you've enjoyed another one of my tutorials and found it helpful.  We're almost done!
--Cheers,
--GT, out!