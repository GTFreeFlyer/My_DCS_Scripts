--Copywrite 2020.  "GTFreeFlyer"
--This tutorial is free to distribute.  It may not be altered, sold, or used for revenue generation without written permission from GTFreeFlyer.  Contact GTFreeFlyer@yahoo.com.
--Use of any poriton of this tutorial requires proper credit given.  i.e. "Example copied from GTFreeFlyer's tutorials."  The credit must include a link to where others can find the tutorials.
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--Welcome to GTFreeFlyer's tutorials for scripting within DCS.

--First, you should never be working with Lua scripts within Notepad.  If so, quit now, download Notepad++ or Visual Studio Code which are both free, then come back.
--I believe Notepad++ is a little more friendly, but I don't know.  I use VS Code which I like a lot.
--Download Notepad++:  https://notepad-plus-plus.org/downloads/
--or
--Download VS Code:  https://code.visualstudio.com/download

--You are reading this line without having downloaded one of those, aren't you?
--We need some level of trust here if we are going to be productive and learn Lua together.
--I already trust you.  Now your turn.
--Go ahead.  Get one of those two apps.  I'll wait...
--.........


--Alrighty then....
--First, let me introduce myself.  You alrady know my callsign, GTFreeFlyer.
--I only started with DCS at the end of 2018.  As I'm typing this now, it is May 2020.  I got really into DCS, and then I also got into mission editing.
--I heard you could do cool stuff with Lua to make your missions even better, but had no idea what Lua even looked like.
--Yeah, that's right!  I'm fairly new to this scripting stuff as well.  So why should you listen to me and go through my tutorials?
--Well, I have a little knowledge with programming, but not much.  
--I learned BASIC a long time ago from one class in high school (MANY years ago), but then did nothing for years until I self-taught myself some VBA to make really cool Excel sheets.
--I also learned a little bit of Python on my own, but never did anything with it.
--When I learned that DCS uses Lua, I decided to have a look at it and it was similar to stuff I had seen, but slightly different.
--I dove into a few tutorials, but nothing really related directly to DCS, and also I had trouble learning Lua through YouTube videos.  I needed soemthing written.
--All the written stuff online was too complex for me to understand and figure out how to relate it to DCS.
--Also, everyone who taught Lua on YouTube was some experienced "Coder" speaking some sort of english language I was not familiar with.
--There HAD TO BE A BETTER WAY.

--Well, screw it, I couldn't find a better way.
--After more than a year and half doing this, I've learned a lot, specifically for my DCS hobby, and I'm here to share it with you now... in a better way!
--I'll speak to you like a real human being, and I'm f***ing sorry if I don't use proper terminology.  I learned only what was needed to make good shit in DCS.
--Yeah, that's how our tutorials are going to go.  You have been warned.
--So, if you are trying to make a career out of programming, please for the love of God DO NOT use my tutorials.
--If you are a seasoned programming professional, please don't knock on my "incorrect" techniques.  We're not here to learn programming at any level above beginner hobbyist.
--I'm just a normal DCS hobbyist speaking to other normal DCS hobbyists in a "normal" way that will be easy for the first-time-programmer to understand.
--That's what these tutorials are.  If you are new to programming and want to do cool stuff in DCS, I promise you'll love these tutorials.
--We'll also use plenty of DCS examples and have fun with it.

--Okay, let's go!

--First lesson in LUA is that any line that starts with a double dash "--" like this one means it is only a comment.
--Comments are ignored when the script is running. They are used only to take notes for yourself so you can easily read through code.
--A good programmer uses comments often because when you take a break from your code and return to it, you'll forget stuff from before, so comments help refresh your memory.
--Comments are also good to help others follow along in your code, just like we are going to do right now!
--Also, Lua is case-sensitive.  Keep that in mind!
--I have to repeat that... Lua is case-sensitive!
--I have to repeat that again... Lua is case-sensitive!

--Next part is simple.  Just like any real-world class, you need some backup materials like textbooks, etc.
--We won't use textbooks here, but I NEED YOU TO BOOKMARK these pages.  We will be using them throughout our tutorials.
-----Lua online interpreter:  https://repl.it/languages/lua
-----Library of DCS functions:  https://wiki.hoggitworld.com/view/Category:Functions

--Alright, back to a little discussion...
--Programming requires a little imagination.  You have to have an idea, and a little creativity to accomplish what you want.
--There is no correct way, and no wrong way to write your script.  Everyone does it differently, and you'll find which way works best for you.
--If you just jump straight into it, you won't know what the heck to do.  
--You need to know what tools are available for you to work with, and then your imagination will run wild and you'll create cool stuff :)

--Imagine you own a house, and some water pipe just burst and you have water shooting everywhere.
--Well, you probably know there is a shut-off valve outside your house, and that's where you go first to get the leak to stop.
--If you didn't know about the shut-off valve, you'd spend hours on the online forums asking stupid questions while your house filled up with water.
--Right?  Ok, now the leak has stopped.  What do you do next?  Fix it!  What tools are required?  Where do I even go to buy these tools?
--Once you figure out which store to walk into, the next step would be to figure out what tools are required to get the job done.
--Now you have a new problem... How do you use that damn tool?

--Programming in DCS (or anywhere) is very much like fixing your damn house.
--You should have just kept renting that damn apartment, but no, you wanted to do things your own way, so now you have to figure this out on your own.
--In our analogy, we need to know where to go to find "tools" available to us.
--DCS has a whole library of cool Lua functions that are available to us.  This is our "hardware store".  Let's take a walk in the front door together...
--Go ahead and open up https://wiki.hoggitworld.com/view/Category:Functions
--Oooh, look at all this fancy stuff!  
--I want to make something explode in my mission!  How do I do that?
--Oooh, look!  There's something called "DCS func explosion".  Let's click on that.
--"Creates an explosion at a given point at the specified power"
--Heheheh.... I am having evil thoughts already!
--You probably have no idea how to use this yet, but don't worry.  By the end of my series of tutorials you will be a pro.
--I now want you to just spend a few minutes looking through the library of different functions available in DCS, and start to think what you might be able to do with each one of them.
--Just like in the hardware store, after your water pipe broke, you probably spent some time walking up and down the aisles looking at all the different tools and coming up with ideas.
--Go ahead, I can wait.  I'm not actually here waiting and bored while you go "shopping."  Take your time.  Walk up and down those aisles in https://wiki.hoggitworld.com/view/Category:Functions
--Don't worry about not understanding anything you look at.  Just get a feel for things you might be able to do.  We'll learn them soon enough.  Don't worry.

--Our next lesson will show you the entire process from creating something from scratch all the way through loading it into the mission and flying with it!
--We won't learn any programming in the next lesson.  I just want you to see the entire process at least once before we start digging into the details.
--With that being said, I have carefully laid out all my tutorials in a specific order.  I urge you not to skip around, as you might get lost.
--One lesson builds upon the next, so make sure you go through my tutorials IN ORDER.

--Our lessons will go as follows:
-----Lesson 0:  "Intoduction to DCS Lua Scripting" ... Hey! That's this one that you are reading right now!
-----Lesson 1:  "Diving Right In"
-----Lesson 2:  "Simple F10 Menu"
-----Lesson 3:  "Index-Value Tables"
-----Lesson 4:  "Advanced F10 Menu"
-----Lesson 5:  "Key-Value Tables"
-----Lesson 6:  "Lua Functions"
-----Lesson 7:  "Getting Loopy"
-----Lesson 8:  "Searching Through Tables"
-----Lesson 9:  "Interpreting DCS Scripting Functions"
-----Lesson 10: "Debugging Errors in Your Script"
-----Lesson 11: "Putting It All Together - Building from Scratch"

--These lessons above will wrap up our initial instruction on Lua scripting.  You'll be able to do a TON of stuff and make complex missions with what you've learned.
--As time goes on, I'm sure there will be requests to learn more, so I'll keep adding tutorials as needed and will list them below here.
--They will likely be single topics which can be learned in any order.  Make sure to check back from time-to-time.

-----Lesson 12: "Writing Out to a File"

--Alright, before I go, I just wanted to give you my contact info.  Feel free to shoot me a message and let me know how you are doing throughout these tutorials.
--I might be available to help answer any questions or at least point you in the correct direction.
--GTFreeFlyer in the ED Forums
--GTFreeFlyer@yahoo.com
--GTFreeFlyer in Discord (you can find me in many popular servers such as DCS World's server, etc.)

--I urge you to shoot me a message and share your creations with me when you've made something you are proud of, no matter how simple or complicated it may be.
--It would be very humbling to see that I was able to help people create amazing things.
--This is the fuel all creators need to continue helping out and doing whatever we can to produce more for the community.
--Of course, you can always buy me a beer to if you'd like ;)  Paypal GTFreeFlyer@yahoo.com, or Patreon.com/GTFreeFlyer.  Completely optional!

--Are you sure you're ready for this?
--Cheers,
--GT, out!