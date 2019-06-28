# 100DaysHackingWithSwift
Project from https://www.hackingwithswift.com/100/

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

