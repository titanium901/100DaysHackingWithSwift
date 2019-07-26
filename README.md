# 100DaysHackingWithSwift
Project from https://www.hackingwithswift.com/100/

#### Milestone Projects: Make Projects from scratch

##### Projects:  We write the code for the teacher

##### Challenge: Improve the finished project and apply knowledge in practice

<img width="754" alt="sws" src="https://user-images.githubusercontent.com/30910230/56293950-bbe33700-6132-11e9-83bf-5f1178382e2d.png">

# Project1 - Storm Viewer
Challenge:
Use Interface Builder to select the text label inside your table view cell and adjust its font size to something larger – experiment and see what looks good.
In your main table view, show the image names in sorted order, so “nssl0033.jpg” comes before “nssl0034.jpg”.
Rather than show image names in the detail title bar, show “Picture X of Y”, where Y is the total number of images and X is the selected picture’s position in the array. Make sure you count from 1 rather than 0.


![storm](https://user-images.githubusercontent.com/30910230/59509462-c3685780-8eb9-11e9-9e5b-368c574cd947.gif)

# Project2 - Gues the Flag
Challenge:
Try showing the player’s score in the navigation bar, alongside the flag to guess.
Keep track of how many questions have been asked, and show one final alert controller after they have answered 10. This should show their final score.
When someone chooses the wrong flag, tell them their mistake in your alert message – something like “Wrong! That’s the flag of France,” for example.

![countryGame](https://user-images.githubusercontent.com/30910230/59517839-20213d80-8ecd-11e9-89db-59f68544f769.gif)

# Project3 - 3.1
add UIActivityViewController to previous project

Challenge:
Try adding the image name to the list of items that are shared. The activityItems parameter is an array, so you can add strings and other things freely. Note: Facebook won’t let you share text, but most other share options will.
Go back to project 1 and add a bar button item to the main view controller that recommends the app to other people.
Go back to project 2 and add a bar button item that shows their score when tapped.

![pr3and3 1](https://user-images.githubusercontent.com/30910230/59692159-06456a80-91ed-11e9-91ae-17cb33742c51.gif)

# Project Milestone: Projects 1-3
Challenge:
You have a rudimentary understanding of table views, image views, and navigation controllers, so let’s put them together: your challenge is to create an app that lists various world flags in a table view. When one of them is tapped, slide in a detail view controller that contains an image view, showing the same flag full size. On the detail view controller, add an action button that lets the user share the flag picture and country name using UIActivityViewController.

To solve this challenge you’ll need to draw on skills you learned in tutorials 1, 2, and 3:

Start with a Single View App template, then change its main ViewController class so that builds on UITableViewController instead.
Load the list of available flags from the app bundle. You can type them directly into the code if you want, but it’s preferable not to.
Create a new Cocoa Touch Class responsible for the detail view controller, and give it properties for its image view and the image to load.
You’ll also need to adjust your storyboard to include the detail view controller, including using Auto Layout to pin its image view correctly.
You will need to use UIActivityViewController to share your flag.

![pr1-3](https://user-images.githubusercontent.com/30910230/59692368-72c06980-91ed-11e9-940d-49e8e210ed39.gif)

# Project4 

Challenge:
If users try to visit a URL that isn’t allowed, show an alert saying it’s blocked.
Try making two new toolbar items with the titles Back and Forward. You should make them use webView.goBack and webView.goForward.
For more of a challenge, try changing the initial view controller to a table view like in project 1, where users can choose their website from a list rather than just having the first in the array loaded up front.

![pr4](https://user-images.githubusercontent.com/30910230/59765827-98aa4480-92a7-11e9-8739-a6c965c4b35e.gif)

# Project5
Word scramble
Challenge:
Disallow answers that are shorter than three letters or are just our start word. For the three-letter check, the easiest thing to do is put a check into isReal() that returns false if the word length is under three letters. For the second part, just compare the start word against their input word and return false if they are the same.
Refactor all the else statements we just added so that they call a new method called showErrorMessage(). This should accept an error message and a title, and do all the UIAlertController work from there.
Add a left bar button item that calls startGame(), so users can restart with a new word whenever they want to.
Bonus: Once you’ve done those three, there’s a really subtle bug in our game and I’d like you to try finding and fixing it.

To trigger the bug, look for a three-letter word in your starting word, and enter it with an uppercase letter. Once it appears in the table, try entering it again all lowercase – you’ll see it gets entered. Can you figure out what causes this and how to fix it?

![pr5](https://user-images.githubusercontent.com/30910230/59852993-a67bca80-9378-11e9-85c3-4672bfcffa0a.gif)

# Project6
Challenge:
Try replacing the widthAnchor of our labels with leadingAnchor and trailingAnchor constraints, which more explicitly pin the label to the edges of its parent.
Once you’ve completed the first challenge, try using the safeAreaLayoutGuide for those constraints. You can see if this is working by rotating to landscape, because the labels won’t go under the safe area.
Try making the height of your labels equal to 1/5th of the main view, minus 10 for the spacing. This is a hard one, but I’ve included hints below!

![pr6](https://user-images.githubusercontent.com/30910230/59853569-cbbd0880-9379-11e9-934f-90c89752db77.gif)

# Project Milestone: Projects 4-6
Shopping list

Challenge:
The best way to tackle this app is to think about how you build project 5: it was a table view that showed items from an array, and we used a UIAlertController with a text field to let users enter free text that got appended to the array. That forms the foundation of this app, except this time you don’t need to validate items that get added – if users enter some text, assume it’s a real product and add it to their list.

For bonus points, add a left bar button item that clears the shopping list – what method should be used afterwards to make the table view reload all its data?

Here are some hints in case you hit problems:

Remember to change ViewController to build on UITableViewController, then change the storyboard to match.
Create a shoppingList property of type [String] to hold all the items the user wants to buy.
Create your UIAlertController with the style .alert, then call addTextField() to let the user enter text.
When you have a new shopping list item, make sure you insert() it into your shoppingList array before you call the insertRows(at:) method of your table view – your app will crash if you do this the wrong way around.
You might be tempted to try to use UIActivityViewController to share the finished shopping list by email, but if you do that you’ll hit a problem: you have an array of strings, not a single string.

![pr4-6](https://user-images.githubusercontent.com/30910230/59853261-2ace4d80-9379-11e9-92d4-3e0fb3b2a2c5.gif)

# Project 7
Work with white house petitions api

Challenge:
Add a Credits button to the top-right corner using UIBarButtonItem. When this is tapped, show an alert telling users the data comes from the We The People API of the Whitehouse.
Let users filter the petitions they see. This involves creating a second array of filtered items that contains only petitions matching a string the user entered. Use a UIAlertController with a text field to let them enter that string. This is a tough one, so I’ve included some hints below if you get stuck.
Experiment with the HTML – this isn’t a HTML or CSS tutorial, but you can find lots of resources online to give you enough knowledge to tinker with the layout a little.

![pr7](https://user-images.githubusercontent.com/30910230/59931785-74d53300-944e-11e9-813d-19645a6afad2.gif)

# Project 8 
Challenge:
Use the techniques you learned in project 2 to draw a thin gray line around the buttons view, to make it stand out from the rest of the UI.
If the user enters an incorrect guess, show an alert telling them they are wrong. You’ll need to extend the submitTapped() method so that if firstIndex(of:) failed to find the guess you show the alert.
Try making the game also deduct points if the player makes an incorrect guess. Think about how you can move to the next level – we can’t use a simple division remainder on the player’s score any more, because they might have lost some points.

![pr8](https://user-images.githubusercontent.com/30910230/60033304-00e69500-96b1-11e9-8398-bfe8f6e91e6a.gif)

# Project Milestone: Projects 7-9

Challenge: This is the first challenge that involves you creating a game. You’ll still be using UIKit, though, so it’s a good chance to practice your app skills too.

The challenge is this: make a hangman game using UIKit. As a reminder, this means choosing a random word from a list of possibilities, but presenting it to the user as a series of underscores. So, if your word was “RHYTHM” the user would see “??????”.

The user can then guess letters one at a time: if they guess a letter that it’s in the word, e.g. H, it gets revealed to make “?H??H?”; if they guess an incorrect letter, they inch closer to death. If they seven incorrect answers they lose, but if they manage to spell the full word before that they win.

![ml7-9](https://user-images.githubusercontent.com/30910230/60273688-544e2280-98ff-11e9-9705-20ba255ff157.gif)
![pr-710v2](https://user-images.githubusercontent.com/30910230/60675329-cd5ff380-9e84-11e9-8d5c-1bcb9b531841.gif)


# Project 10
Challenge:
Add a second UIAlertController that gets shown when the user taps a picture, asking them whether they want to rename the person or delete them.
Try using picker.sourceType = .camera when creating your image picker, which will tell it to create a new image by taking a photo. This is only available on devices (not on the simulator) so you might want to check the return value of UIImagePickerController.isSourceTypeAvailable() before trying to use it!
Modify project 1 so that it uses a collection view controller rather than a table view controller. I recommend you keep a copy of your original table view controller code so you can refer back to it later on.


![pr10](https://user-images.githubusercontent.com/30910230/60350628-a14bfa80-99cc-11e9-96ed-c44d2bc02e12.gif)
![pr1 2](https://user-images.githubusercontent.com/30910230/60350859-29ca9b00-99cd-11e9-8c10-cc89d3b83383.gif)

# Project 11
Challenge:
The pictures we’re using in have other ball pictures rather than just “ballRed”. Try writing code to use a random ball color each time they tap the screen.
Right now, users can tap anywhere to have a ball created there, which makes the game too easy. Try to force the Y value of new balls so they are near the top of the screen.
Give players a limit of five balls, then remove obstacle boxes when they are hit. Can they clear all the pins with just five balls? You could make it so that landing on a green slot gets them an extra ball.

![pr11](https://user-images.githubusercontent.com/30910230/60351116-bb3a0d00-99cd-11e9-859c-069b494a5f28.gif)

# MilestoneProject10-12
Challenge:
Your challenge is to put two different projects into one: I’d like you to let users take photos of things that interest them, add captions to them, then show those photos in a table view. Tapping the caption should show the picture in a new view controller, like we did with project 1. So, your finished project needs to use elements from both project 1 and project 12, which should give you ample chance to practice.

This will require you to use the picker.sourceType = .camera setting for your image picker controller, create a custom type that stores a filename and a caption, then show the list of saved pictures in a table view. Remember: using the camera is only possible on a physical device.

It might sound counter-intuitive, but trust me: one of the best ways to learn things deeply is to learn them, forget them, then learn them again. So, don’t be worried if there are some things you don’t recall straight away: straining your brain for them, or perhaps re-reading an older chapter just briefly, is a great way to help your iOS knowledge sink in a bit more.

![ml10-12](https://user-images.githubusercontent.com/30910230/60520412-0023b380-9cee-11e9-8063-5b5cdbeb5f81.gif)

# Project 13
Challenge:
Try making the Save button show an error if there was no image in the image view.
Make the Change Filter button change its title to show the name of the currently selected filter.
Experiment with having more than one slider, to control each of the input keys you care about. For example, you might have one for radius and one for intensity.

![pr13v2](https://user-images.githubusercontent.com/30910230/60707091-8ff67700-9f13-11e9-8c2f-61042fe68145.gif)

# Project 14
Challenge:
Record your own voice saying "Game over!" and have it play when the game ends.
When showing “Game Over” add an SKLabelNode showing their final score.
Use SKEmitterNode to create a smoke-like effect when penguins are hit, and a separate mud-like effect when they go into or come out of a hole.

![pr14](https://user-images.githubusercontent.com/30910230/60707191-d5b33f80-9f13-11e9-9922-63d7d36e08f6.gif)

# Project 15
Challenge:
Go back to project 8 and make the letter group buttons fade out when they are tapped. We were using the isHidden property, but you'll need to switch to alpha because isHidden is either true or false, it has no animatable values between.
Go back to project 13 and make the image view fade in when a new picture is chosen. To make this work, set the alpha to 0 first.
Go back to project 2 and make the flags scale down with a little bounce when pressed.

![pr15](https://user-images.githubusercontent.com/30910230/60707368-393d6d00-9f14-11e9-8cad-d37de304fbb9.gif)

# Project Milestone: Projects 13-15
Challenge:
Your challenge is to make an app that contains facts about countries: show a list of country names in a table view, then when one is tapped bring in a new screen that contains its capital city, size, population, currency, and any other facts that interest you. The type of facts you include is down to you – Wikipedia has a huge selection to choose from.

To make this app, I would recommend you blend parts of project 1 project 7. That means showing the country names in a table view, then showing the detailed information in a second table view.

How you load data into the app is going to be an interesting problem for you to solve. I suggested project 7 above because a sensible approach would be to create a JSON file with your facts in, then load that in using contentsOf and parse it using Codable. Regardless of how you end up solving this, I suggest you don’t just hard-code it into the app – i.e., typing all the facts manually into your Swift code. You’re better than that!

![ml13-15](https://user-images.githubusercontent.com/30910230/60728039-0d3bdf00-9f48-11e9-9ff9-d76928c9d9f4.gif)

# Project 16
Challenge:
Try typecasting the return value from dequeueReusableAnnotationView() so that it's an MKPinAnnotationView. Once that’s done, change the pinTintColor property to your favorite UIColor.
Add a UIAlertController that lets users specify how they want to view the map. There's a mapType property that draws the maps in different ways. For example, .satellite gives a satellite view of the terrain.
Modify the callout button so that pressing it shows a new view controller with a web view, taking users to the Wikipedia entry for that city.

![pr16](https://user-images.githubusercontent.com/30910230/60728105-35c3d900-9f48-11e9-863f-46dfd056de82.gif)

# Project 17 

Challenge:
Stop the player from cheating by lifting their finger and tapping elsewhere – try implementing touchesEnded() to make it work.
Make the timer start at one second, but then after 20 enemies have been made subtract 0.1 seconds from it so it’s triggered every 0.9 seconds. After making 20 more, subtract another 0.1, and so on. Note: you should call invalidate() on gameTimer before giving it a new value, otherwise you end up with multiple timers.
Stop creating space debris after the player has died.

![pr17](https://user-images.githubusercontent.com/30910230/60825013-6a879880-a1b3-11e9-8376-2e681a429583.gif)

# Project Milestone: Projects 16-18

Challenge:
How you implement this game really depends on what kind of shooting gallery games you’ve played in the past, but here are some suggestions to get you started:

Make some targets big and slow, and others small and fast. The small targets should be worth more points.
Add “bad” targets – things that cost the user points if they get shot accidentally.
Make the top and bottom rows move left to right, but the middle row move right to left.
Add a timer that ticks down from 60 seconds. When it hits zero, show a Game Over message.
Try going to https://openclipart.org/ to see what free artwork you can find.
Give the user six bullets per clip. Make them tap a different part of the screen to reload.
Those are just suggestions – it’s your game, so do what you like!

Video - https://twitter.com/i/status/1148889952006103040

![ml16-18](https://user-images.githubusercontent.com/30910230/60964626-73e04480-a31c-11e9-82c3-edee4d4187c5.gif)

# Project20

Challenge:
For an easy challenge try adding a score label that updates as the player’s score changes.
Make the game end after a certain number of launches. You will need to use the invalidate() method of Timer to stop it from repeating.
Use the waitForDuration and removeFromParent actions in a sequence to make sure explosion particle emitters are removed from the game scene when they are finished.

![pr20](https://user-images.githubusercontent.com/30910230/61382394-621b1600-a8b5-11e9-9b25-819952a15bf4.gif)

# Project21

Challenge:
Update the code in didReceive so that it shows different instances of UIAlertController depending on which action identifier was passed in.
For a harder challenge, add a second UNNotificationAction to the alarm category of project 21. Give it the title “Remind me later”, and make it call scheduleLocal() so that the same alert is shown in 24 hours. (For the purpose of these challenges, a time interval notification with 86400 seconds is good enough – that’s roughly how many seconds there are in a day, excluding summer time changes and leap seconds.)
And for an even harder challenge, update project 2 so that it reminds players to come back and play every day. This means scheduling a week of notifications ahead of time, each of which launch the app. When the app is finally launched, make sure you call removeAllPendingNotificationRequests() to clear any un-shown alerts, then make new alerts for future days.

![pr21](https://user-images.githubusercontent.com/30910230/61546725-a7c11580-aa52-11e9-87f9-12974528b437.gif)

# Project Milestone: Projects 19-21

Your challenge for this milestone is to use those API to imitate Apple as closely as you can: I’d like you to recreate the iOS Notes app. I suggest you follow the iPhone version, because it’s fairly simple: a navigation controller, a table view controller, and a detail view controller with a full-screen text view.

How much of the app you imitate is down to you, but I suggest you work through this list:

Create a table view controller that lists notes. Place it inside a navigation controller. (Project 1)
Tapping on a note should slide in a detail view controller that contains a full-screen text view. (Project 19)
Notes should be loaded and saved using Codable. You can use UserDefaults if you want, or write to a file. (Project 12)
Add some toolbar items to the detail view controller – “delete” and “compose” seem like good choices. (Project 4)
Add an action button to the navigation bar in the detail view controller that shares the text using UIActivityViewController. (Project 3)

![ml19-21](https://user-images.githubusercontent.com/30910230/61546859-ee167480-aa52-11e9-8f22-e0e54b4b3153.gif)


# Project 23

Challenge:
Create a new, fast-moving type of enemy that awards the player bonus points if they hit it.
Add a “Game over” sprite node to the game scene when the player loses all their lives.

![pr23](https://user-images.githubusercontent.com/30910230/61772762-bb2a0300-adfb-11e9-9fe0-2ba8e5ed43f6.gif)

# Project Milestone: Projects 22-24

Your challenge this time is not to build a project from scratch. Instead, I want you to implement three Swift language extensions using what you learned in project 24. I’ve ordered them easy to hard, so you should work your way from first to last if you want to make your life easy!

Here are the extensions I’d like you to implement:

Extend UIView so that it has a bounceOut(duration:) method that uses animation to scale its size down to 0.0001 over a specified number of seconds.
Extend Int with a times() method that runs a closure as many times as the number is high. For example, 5.times { print("Hello!") } will print “Hello” five times.
Extend Array so that it has a mutating remove(item:) method. If the item exists more than once, it should remove only the first instance it finds. Tip: you will need to add the Comparable constraint to make this work!

# Project 25 

Challenge:
Show an alert when a user has disconnected from our multipeer network. Something like “Paul’s iPhone has disconnected” is enough.
Try sending text messages across the network. You can create a Data from a string using Data(yourString.utf8), and convert a Data back to a string by using String(decoding: yourData, as: UTF8.self).
Add a button that shows an alert controller listing the names of all devices currently connected to the session – use the connectedPeers property of your session to find that information.

![Project25](https://user-images.githubusercontent.com/30910230/61958921-f4fd3400-afca-11e9-92a8-9eb8011d3e65.gif)
