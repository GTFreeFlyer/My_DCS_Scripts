--Copywrite 2020.  "GTFreeFlyer"
--This tutorial is free to distribute.  It may not be altered, sold, or used for revenue generation without written permission from GTFreeFlyer.  Contact GTFreeFlyer@yahoo.com.
--Use of any poriton of this tutorial requires proper credit given.  i.e. "Example copied from GTFreeFlyer's tutorials."  The credit must include a link to where others can find the tutorials.
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--Hello there again, stranger!  Although, I feel like we're no longer strangers now that we've been spending some time together.

--Alrighty.  So now we will be "getting loopy".  That is, we will learn how create loops in your script.
--Why?  Well, I suppose you could create a script that just exceutes from the first line down to the last line of code, but...
--...you are most likely going to want to create some sort of loop to keep checking on things continuously throughout a mission.
--It really just depends on what you want to do with your code.  You can even mix it up if you want:
--Such as, you can create a looping script that continuously checks to see if a player is taxiing too fast, and if so...
--...then you can execute another chuck of script that just runs once from top to bottom and cause that pilot's plane to explode in glorious fashion.

--Got it?  Good.  Let's move on.
--We'll learn just the most common loops to get you moving, and likely the only loops you'll really need to do most anything you want with DCS.
--If you want to learn more about loops on your own after this tutorial, just search online for "Lua loops"
--Now we're going to learn:
-----For-Loop
-----While-Loop
-----Exiting a loop
-----Repeat-Until-Loop
-----Scheduling Functions


--Let's dive right into the For-Loop with a simple example.

myScore = 0
for myCounter = 1, 10 do
    myScore = myScore + 10
end

--Congrats!  Your first loop!
--Let's break it down:
--First we created a variable named myScore and we started off with zero points.
--Next, we read that second line as, "For myCounter equals 1 to 10 do the following:".  By doing this, we actually created another variable named myCounter.
--Next, we added our single line of code, which could be millions of lines of code if you'd like it to be, and this increments myScore by 10 points.
--Finally, we must close the for-loop with an "end" command.  
--When the script reaches "end", it will jump back up to the "for" command, auto-increment myCounter to the next number, and continue until myCounter reaches 10.
--This loop will run 10 times.  Each time it runs, myScore gets 10 points added to it.  After the loop is complete, myScore will be equal to 100.

--Nice job!  I knew you'd find that to be easy.
--Okay, I want to point out that you can actually use the myCounter variable within your loop as well:

myScore = 0
for myCounter = 1, 10 do
    myScore = myCounter * 10
end

--Each time the loop goes around, myCounter changes from 1, to 2, to 3, all the way to 10.
--You can see that myScore just keeps getting overwritten, and on the last loop we have myCounter = 10, so myScore = 10 * 10, which equals 100.
--Both for-loop examples abbove give you the same result.  Neither one is right or wrong.  It just depends on what you are trying to do.
--Moving on... There is an optional increment value you can add to the for-loop:

for myCounter = 1, 10, 2 do
    myScore = myScore + 10
end

--This is the same as our first example, except we now see "for myCounter = 1, 10, 2 do"
--That third value (the 2) is our increment value.
--We would read that line as, "For myCounter equals 1 to 10, in steps of 2, do the following:".
--So, mycounter will start at 1, then on the next loop it will be 3, then 5, then 7, then 9.
--It will stop at 9, even though we told it to go from 1 to 10, because after 9 it wants to go to 11 and that is past our limit, so it will stop executing the loop.
--You can even count backwards if you'd like:

for spaceShuttleCountdown = 10, 1, -1 do
    myHeartRate = "Way too fast to be considered healthy"
end

--That's pretty much all there is to learn about For-Loops.
--It's important to always be thinking about what is happening inside your loops, and you MUST make sure there is always a way out of your loops.
--If the script has no way to exit the loop, your script will get into an infinite loop and DCS will just get stuck and use up all your memory.
--Of course, using a For-Loop sort of protects you a little bit, because you are telling it to count from 1 to 10, or whatever it might be.
--However, that may not be the case with the next loop we will learn.  Ready?  Let's go!

--And now, we learn the While-Loop

myScore = 0
while (myScore < 10) do       --"while myScore is less than 10, do the following..."
    myScore = myScore + 1
end

--As you see, very similar to the For-Loop.
--We are telling the loop to continue looping while myScore is less than 10.
--Each time around the loop, we increment myScore by 1 point. 
--Eventually, myScore will be equal to 10, which does not satisfy the requirement of being less than 10, so the loop stops and the script will continue with the next line, whatever you have after "end".
--Now what if you made a mistake with your math...

myScore = 0
while (myScore < 10) do
    myScore = myScore - 1
end

--See, I accidentally set the score to decrease 1 point at a time, instead of increase.
--You have to watch out for these sorts of conditions, because now we are in a loop that will continue looping while myScore is less than 10.
--myScore will ALWAYS be less than 10 in this example, and we have now entered an infinite loop and your DCS has just froze up.
--In fact, it froze up so bad that you probably just went on the forums and reported a bug that was no one's fault other than your own.
--I like to call this the PICNIC issue:  Problem In Chair, Not In Computer.   Yeah dummy, the problem is sitting right there in your chair... yes, YOU!

--Ok, so how can we protect ourselves from this?
--Well, first make sure you are using the correct loop for the situtaion.  Could you have done the same thing with a For-Loop?
--The For-Loop has a defined start and end condition built into it.  Remember?  We defined it to run from 1 to 10.  It stops when reaching the end value we had set.
--The For-Loop isn't always what you need though.  So if you must use a loop such as the While-Loop, perhaps you'll want to build some protection into it...

myScore = 0
myCounter = 0   --this is new, and it will increment each time around the loop
mySafetyLimit = 1000  --this is new, and it is a fixed value that won't change

while (myScore < 10) do
    myScore = myScore - 1  --Oops!  Bad math will get us stuck in an infinite loop
    myCounter = myCounter + 1  --this is new
    if myCounter > mySafetyLimit then  --this is new
        break  --this is new
    end  --this is new
end

--Stare at that last example for a few moments.
--We set a safety limit of 1000 loops.  We probably did this because we expect the loop to run no more than 10 times, and we were just being extra conservative and setting the limit WAY higher at 1000 loops.
--Don't worry, 1,000 loops is NOTHING for your computer.  It will loop the shit out of your script in a matter of a few microseconds.  
--You won't even know you got stuck in a loop for only 1,000 cycles.
--To protect ourselves from an infinite loop, we created another counter that keeps track of how many loops we've done.
--Each time around the loop, we use the if-statement to evaluate the counter.
--If the counter is greater than the safety limit we set, then it will execute the command "break".
--"break" can be used in ANY loop.  If your script comes across this command at any point, it will simply exit the loop you are in as soon as it sees the command "break" (without the quotes, of course)

--Now I have to split off on a tangent real quick...
--When using conditional statements, such as:

while (myScore = 10) do

    --or

if myCounter = mySafetyLimit then

--...THESE WILL FAIL!
--You'll see an error such as, lua: [string "<eval>"]:4: ')' expected near '='
--You can pretty much ingore everything in the error message except the :4:   This will tell you that the error is on line 4 in your script, and you'll know exactly where to look.
--Lua does not like when you use the equals-sign in conditional statements.  The equals-sign is used only when setting a value.  Such as myValue = 12345.
--Instead, YOU MUST USE THE DOUBLE-EQUALS-SIGN in conditional statements.  See here:

while (myScore == 10) do

    --or

if myCounter == mySafetyLimit then

--These will pass and not give you any errors.
--NO MATTER HOW MANY TIMES I'VE WRITTEN SCRIPTS, THIS AWLAYS GETS ME.  I still forget about it from time to time, as it is not easy for your eye to catch the error until you try to run the script.
--Just be aware, and I'm sure you'll have those "smack my head" moments due to this at some point during your scripting "career".

--Okie dokie artichokie, two more loops to learn:
--Here comes the Repeat-Until loop.  It is almost identical to the While-Loop, except the conditional statement will be at the end:

myScore = 0
repeat    
    myScore = myScore + 1
until (myScore == 10)

--So as you see, no "end" to close out the loop.  Instead, we use "until" along with the condition which will end the loop.
--I don't really ever use this one myself, but if you have a situation where you need to check the condition at the end of the loop, and not at the beginning, then you can use this one.
--As your script works its way from top to bottom, it will see the "repeat" command and then it will execute the lines inside the loop, until it hits the "until" command.
--Next, if your conditional check is NOT satisfied, it will loop back up to the repeat line and continue over and over until the conditional check IS satisfied.
--Again, watch out from infinite loops.
--That's all I have to say about that!

--And for our last and final loop in this tutorial, we'll talk about something a little different that only works within DCS.
--I use this one ALL THE TIME
--But first, make sure you have gone through my Lua Functions Tutorial so you know what the heck I'm talking about when I talk about functions...

--Sweet, you're ready.  Let me just show it to you first, then we'll talk about it:

function checkMissionFlags() 
    timer.scheduleFunction(checkMissionFlags, nil, timer.getTime() + 60)   
    ourFirstFlag = trigger.misc.getUserFlag("1")  --this is a built-in command within DCS to return the value of flag #1 from the mission editor.
    ourSecondFlag = trigger.misc.getUserFlag("2")
    ourThirdFlag = trigger.misc.getUserFlag("3")
end

checkMissionFlags()

--Ok, this is technically a full script that you could load and it will run as is.  Nothing else required.
--We started off creating our own function which will check flag numbers 1, 2 and 3 in the mission...
--... and then we set our own variables ourFirstFlag, ourSecondFlag, and ourThirdFlag equal to them.  Perhaps we want to do something with these values; maybe some advanced Calculus stuff?
--As the script executes from top to bottom, the first thing it sees is the definition of a funtion named checkMissionFlags.
--IT WILL NOT EXECUTE ANYTHING INSIDE THIS FUNCTION!
--You need to call this function in order to exectue it, and that's exactly what we do on the last line of the script.
--Ok, now that our function has been called from that last line of code, we jump back up to the function in order to execute it.
--Inside the function, the first line to execute is:

timer.scheduleFunction(checkMissionFlags, nil, timer.getTime() + 60)   

--... and this is how we are creating a loop!
--timer.scheduleFunction is a function itself and it only works with DCS.
--We must give this function three items, called arguments.

timer.scheduleFunction(argument1, argument2, argument3)

--Argument1 is the name of the function which we would like to schedule to run some time in the future.
--Argument2 would be any arguments we would like to pass into the function we are trying to schedule, in this case none (so we write nil) because checkMissionFlags() does not require arguments to be passed into it.
--Argument3 would be the time, in seconds, of the mission when you want your function to run.

--Note that for Argument3, you are most likely going to want to schedule your function to run a certain "time from right now"...
--...and not from a specific time in the mission, such as 32874 seconds into the mission.  The time returned from the timer.getTime command still moves forward even if the mission is paused.

--In our example, we are using timer.getTime() + 60
--This means we are getting the current time since the mission has loaded and adding 60 seconds to it.
--So what have we done?

--From the beginning...
--We have called our function, checkMissionFlags(), and then the very first thing we do inside that function is schedule it to run itself again in 60 seconds.
--Yup, we opened up our calendar, wrote a little note to ourselves saying, "Hey dude, run checkMissionFlags() again in 60 seconds from now", and then closed our calendar.
--Now deep inside the "brains" of our code, in a mysterious black hole in space, some little magical gnome has started his stopwatch for us and we can move on.
--After we schedule our function to run, we move on to the next three lines of code and get our flag values.
--That's it!  Our script has come to an end and it is no longer doing anything.
--But wait!  60 seconds have now passed and that magical gnome's alarm clock has just started beeping.
--This gnome has woken up your script all over again, now running checkMissionFlags() exactly on time, just as you wrote it down in your calendar.
--Guess what?  The first line of code in your function adds it right back into your calendar to execute in another 60 seconds from now...
--... aaaaannnnddd WE HAVE CREATED OUR LAST LOOP for this tutorial.

--One last important note...
--You must have all functions defined before you try to call any of them!

checkMissionFlags()
function checkMissionFlags() 
--  Your code in here
end

--This will give an error because Lua works from the top to the bottom.
--The first thing it sees is your request to run checkMissionFlags(), and it simply poops on you.
--Lua has no idea what checkMissionFlags() is.  
--Lua is a lazy bitch and won't even bother looking through your script to figure it out on its own.
--Lua will simply just throw its hands up in the air and give you an error message, then stop running.
--You'll want to shoot it in its face with your A-10's gun, but nope, your script is broken and now you have to restart your mission.
--Make sure you define your functions before you try to call them!

--Hope you enjoyed! See you soon.
--Cheers,
--GT, out!