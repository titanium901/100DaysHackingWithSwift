# 100DaysHackingWithSwift
Project from https://www.hackingwithswift.com/100/

<img width="754" alt="sws" src="https://user-images.githubusercontent.com/30910230/56293950-bbe33700-6132-11e9-83bf-5f1178382e2d.png">

# Project1 - Storm Viewer

![storm](https://user-images.githubusercontent.com/30910230/59509462-c3685780-8eb9-11e9-9e5b-368c574cd947.gif)

# Project2 - Gues the Flag

![countryGame](https://user-images.githubusercontent.com/30910230/59517839-20213d80-8ecd-11e9-89db-59f68544f769.gif)

# Project3 - 3.1
add UIActivityViewController to previous project

![pr3and3 1](https://user-images.githubusercontent.com/30910230/59692159-06456a80-91ed-11e9-91ae-17cb33742c51.gif)

# Project Milestone: Projects 1-3

![pr1-3](https://user-images.githubusercontent.com/30910230/59692368-72c06980-91ed-11e9-940d-49e8e210ed39.gif)

# Project4 

Challenge:
One of the best ways to learn is to write your own code as often as possible, so here are three ways you should try extending this app to make sure you fully understand what’s going on:

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

