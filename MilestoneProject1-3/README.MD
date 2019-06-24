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
