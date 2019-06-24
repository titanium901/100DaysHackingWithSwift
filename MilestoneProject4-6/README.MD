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
