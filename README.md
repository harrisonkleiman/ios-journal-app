# ios-journal-app

Journal
Students will build a simple journal app to practice MVC separation, segues, table views, and persistence.

Journal is an excellent app to practice basic Cocoa Touch principles and design patterns. Students are encouraged to repeat building journal regularly until they master the principles and patterns, eventually being able to build journal without the help of a guide.

Students who complete this project independently can:

Day One

Understand basic model-view-controller design and implementation

Create a custom model object with a memberwise initializer

Understand, create, and use a shared instance

Create a model object controller with create and delete functions

Implement the Equatable protocol

Understand and implement the UITextFieldDelegate protocol to dismiss the keyboard

Create relationship segues in Storyboards

Implement prepare(for segue: UIStoryboardSegue, sender: Any?) to configure destination view controllers

Understand, use, and implement the updateViews pattern

Save and load data using JSON Persistence and the Codable protocol

Day Two

Be able to use multiple models in the mvc design pattern

Be able to refactor an application to reference a new source of truth

Implement an update function on the model controller to update existing data

Day Two - Controller Implementation
Today you are going to expand upon your Journal application. So far you have a single journal that can store one or many entries. We are going to refactor our application so that we can have an array of journals (ex. Travel Journal, Pain Journal, etc…). In order to do this, a few things are going to have to change. For starters, we won’t have a source of truth that contains an array of entries anymore. Instead, you will need to have a source of truth that contains an array of journals, and each journal will hold an array of entries. Here is a breakdown of what you will need to do: 1. Create a Journal model. 2. Create a Journal model controller. 3. Move persistence methods from the EntryController to the JournalController. 4. Refactor the storyboards to start with a list of Journals. 5. Add an update(entry: Entry) function to the EntryController.

Journal
Create a Journal model class that will hold a title and an entries property.

Add a new Journal.swift file and define a new Journal class.

Add properties for title and entries (hint: entries will be an array of Entry).

3. Add a memberwise initializer that takes parameters for each property. * Consider setting a default parameter value for the entries array.

JournalController
Create a model object controller called JournalController that will manage creating, deleting and updating journals. Steps 6 and 7 are going to take a little bit of thinking. Give it your best shot! If you are stuck for more than 20 minutes send a message in the queue channel.

Add a new JournalController.swift file and define a new JournalController class within then class.

Create a shared property as a shared instance.

Add a journals array property, and set its value to an empty array of Journal.

Create a createJournalWith(title: String) function that takes in a title. It should create a new instance of Journal and add it to the journals array

Create a delete(journal: Journal) function that removes the journal from the journals array. Find the index of the object and then remove the object at that index. You will face a compiler error because we have not given the ``Journal`` class a way to find equal objects. To resolve the error, implement the Equatable protocol on the ``Journal`` class.

Create an addEntryTo(journal: ...) function that should take in an existing journal as a parameter as well as an entry. In the body of this function append the entry to the journals array of entries.

Create a removeEntryFrom(journal: ...) function that should take in an existing journal as a parameter as well as an entry. In the body of this function you will need to find the index of the given entry, and then remove the object at that index from the given journal’s array of entries.

Add Data Persistence functionality to the JournalController
With our EntryController no longer being the best location for our source of truth, we are going to have to refactor it quite significantly. Starting with changing the location of our persistence functions.

Copy the fileURL() function on our EntryController and paste it at the bottom of the JournalController.

Write a saveToPersistentStorage() method that will save the current journals array (hint: this will look exactly like the saveToPersistentStorage() method you have on the EntryController, except it will save journals instead of entries). You code will likely give you an error. We cannot encode or decode without first making our model Codable.

Write a loadFromPersistentStorage() method that will load the saved data (hint: this will look exactly like the loadFromPersistentStorage() method you have on the EntryController, except it will load journals instead of entries).

You can now delete the persistence functions (fileURL(), saveToPersistentStorage(), and loadFromPersistentStorage()) from the EntryController altogether. You will also need to go into each CRUD function on the EntryController and remove the saveToPersistentStorage() function.

Back on the JournalController, make sure to call saveToPersistentStorage() at the end of each one of your CRUD functions, if you have not already.

Refactor EntryController
We still need to do a little more refactoring to our EntryController.

We no longer need an entries array (former source of truth), because our entries will now be on a journal object. So delete var entries: [Entry] = [] (ignore any errors for the moment).

Because we no longer have an entries source of truth, there is not a need to have a shared instance. Sure, it gives us access to these functions, but that is not a good enough reason to have a shared instance. So delete static let shared = EntryController().

We have now trimmed down our EntryController significantly, and what remains has errors. The remaining code is attempting to utilize the entries array that no longer exists.

In the createEntryWith() function, remove entries.append(newEntry) and instead call the addEntryTo() function that lives on your JournalController. You will note that this function requires you to pass in a journal, which means you will also need to modify the createEntryWith() function parameters to take in a journal and then pass that journal into your createEntryWith() function.

In the deleteEntry() function, remove all the code. None of it will work. However, you have already written the code needed for this work. Simply call your removeEntryFrom() function located in your JournalController. Like Step 3, this function requires a journal. So, modify the the deleteEntry() function parameters to take in a journal and then pass that journal into your removeEntryFrom() function.

Now, because EntryController no longer has a shared instance, these functions are no longer accessible. To make them accessible, add the static keyword before both functions.

If you were to build now you would notice we have a few errors. That is because you have multiple lines of code referring to an EntryController.shared which no longer exists. Don’t worry, it will all be taken care of.

Refactor Storyboard
Delete the Navigation Controller in your Main.storyboard. This is going to make your add button () and save button () disappear. Don’t freak out though. They are actually still hiding in there.

Add a View Controller (yes - a viewController, not a tableViewController) to your Main.storyboard and then embed it in a Navigation Controller. Hint: You will need to reset your storyboards initial view controller.

Add a view to the top of your view controller and constrain it to have a height of 100, be 32 points from the top, and 0 points from the view controllers leading and trailing edges.

Add a table view to the view controller you just added. Give the table view 1 prototype cell. Set the cell to have a style of right detail. Give the cell an identifier of journalCell.

Constrain your table view with 0’s on all sides (top should be referring to the view you just added).

Add a show segue from the cell to your EntryListTableViewController. This should bring your add bar button and save bar button back. Give the segue an identifier of toEntryList.

Add a textField and a button to the view at the top of your view controller. Embed them in a stack view and make sure the axis is set to vertical. Set the alignment to Fill, the distribution to Fill Equally, and the spacing to 8.

Constrain the stack view to be centered horizontally and vertically in the view. Set it to have a width equal to 80% of the view.

Give the textField some placeholder text like, Enter Journal Title Here... and give the button a label like, Create New Journal.

You might have noticed that the view controller still has no class, and that is correct. That is because we have not created a view controller file to control this view controller scene. Next you will create that view controller file, connect the outlets and actions, and build out the necessary functions. After that, you will modify the EntryListTableViewController and EntryDetailViewController as needed.

JournalListViewController
Create a view controller called JournalListViewController that will manage your Journal List view controller scene.

Add a new JournalListViewController file (subclass of a UIViewController) and delete boiler-plate comments that you don’t want.

Class your Journal List view controller in your Main.storyboard as a JournalListViewController.

Connect your text field outlet and name it journalTitleTextField.

Connect your create new journal button action and name it createNewJournalButtonTapped. You will come back and build out this function on step 8.

Connect your tableView outlet and name it journalListTableView. Don’t forget to set your dataSource and delegate for your ``journalListTableView`` (hint: this will prompt you with an error, fix it).

Build out your two dataSource functions numberOfRowsInSection and cellForRowAt. In ``cellForRowAt``, include the title of your journal and the count of it’s entries. You will notice that ``cellForRowAt`` does not include a default cell that a tableViewController provides for you. You will need to add this yourself. Give it your best shot. Reference your EntryListTableViewController for help. Reach out in the queue channel if you have not solved it after 20 minutes.

Now, when you navigate (or segue) over to your EntryListTableViewController, you need to tell your EntryListTableViewController which journal’s entries to load. This is where prepare(for segue) is crucial. This function allows you to pass a specific journal over. Build out your prepare(for segue) function, and pass over whichever journal the user selected. Hint 1: You will notice that you don’t have access to a tableView in your ``prepare(for segue)`` function. You will need to access the ``indexPathForSelectedRow`` of your ``journalListTableView``. Hint 2: Make sure to go to your ``EntryListTableViewController`` and give it a landing pad to receive a journal. This should be an optional Journal.

Let’s not forget about our createNewJournalButtonTapped. In the body of this IBAction, use the text from your journalTitleTextField (making sure it is not empty) to create a new journal. After calling your createJournalWith() function, tell your journalListTableView to reload its data, and set the journalTitleTextField back to an empty string.

Finally, before you move on, go up to your lifecycle methods and the viewWillAppear() method. Inside this method, tell your table view to reload its data. That way, when you navigate back to this page, you can show the updated amount of entries in any given journal.

Refactor EntryListTableViewController
Finally, you can fix some of those errors that have been showing on your EntryListTableViewController. To do this, you are going to refactor your dataSource methods to refer to the entries of the Journal you just passed over, instead of using EntryController.shared.entries, which no longer exists. (Hint: Make sure you are using auto-complete as you type your code.)

Remove the EntryController.shared.loadFromPersistentStorage() line of code in your viewDidLoad(). It is no longer necessary. Our app now loads our data when it launches to the JournalListViewController.

Update your numberOfRowsInSection method to return the count of the entries of your journal property. Hint: Because the journal is optional, and cannot be guaranteed to be there, you will need unwrap it. Or, this might be a good occasion to use nil-coalescing.

Update your cellForRowAt method to refer to a specific entry from the array of entries on your journal property. Hint: Because the journal is optional, and cannot be guaranteed to be there, you will need unwrap it. If it is nil, you will want to return a ``UITableViewCell()``.

Update your commit editingStyle method to refer to a specific entry from the array of entries on your journal property. Delete the EntryController.shared.deleteEntry(entry: entryToDelete) line of code and retype it. This time, you will not need to use the a shared instance. So your line of code should look something like this: EntryController.deleteEntry(entry: <#T##Entry#>, journal: <#T##Journal#>). Make sure to pass in your entry and journal. Hint: Because the journal is optional, and cannot be guaranteed to be there, you will need unwrap it.

Like with steps 2, 3, and 4, you will need to update your prepare(for segue) method to refer to a specific entry from your journal property. Hint: Because the journal is optional, and cannot be guaranteed to be there, you will need unwrap it.

Refactor EntryDetailViewController
You will notice you still have one error on your EntryDetailViewController. It is trying to call EntryController.shared which no longer exists.

Delete that line of code and recall the function without using a shared instance. You will see that there is still a problem. You need to pass in a journal, but do not have access to one. You will fix this over the next few steps.

Add an optional journal property below your var entry: Entry?.

Within your guard statement in saveButtonTapped(), unwrap your optional journal.

Pass in the unwrapped title, body, and journal to your EntryController.createEntryWith() function.

Update EntryListTableViewController to pass a Journal
Go back to your prepare(for segue) method on your EntryListTableViewController and pass over your unwrapped journal to your destination’s journal property.

Now, while this will pass a journal over to the EntryDetailViewController if you select an existing journal, it will not work if you click the add button in the top right hand corner to create a new entry. To fix this, you need to look at your prepare(for segue) method. It has code that checks if segue.identifier == "showEntry". If it does not, however, we still need to pass the journal over. So, add on else if segue.identifier == "createNewEntry". In here, you will need to unwrap the destination and journal, and set the destination’s journal property to the value of that unwrapped journal. Hint: Don’t forget to give the segue an identifier on your Main.storyboard.

Run your app. You should see a near-complete, working app. If you do not, spend 20 minutes debugging and then send a message in the queue channel if your bugs are not resolved. You have one final change to make. At the moment, if we click on a journal’s entry, we can see it displayed in the detail view. However, if we make changes to it and click save, none of the changes are actually saved. Instead we see a print out in our debug console saying “We will handle this tomorrow.” Well, tomorrow is today, so let’s handle it…

Add update( ) to EntryController
At the moment, we don’t have a function to update an entry, so go to your EntryController and add a static function called update(). It should take in 3 parameters: an entry, a title, and a body.

In the body of update(), set the passed in entry’s title to the passed in title, and the entry’s body to the passed in body. Hint: If you get any errors here, go and check the properties on your ``Entry`` model. Are they constants or variables?

Now, you need to save your changes. In order to do this, call the saveToPersistentStorage() function on your JournalController.

EntryDetailViewController - the final edit
Go to your EntryDetailViewController and, inside your saveButtonTapped() IBAction, replace print("We will handle this tomorrow.") with a call to your newly created update() function on your EntryController.

Run your app. It should be working perfectly now! If it does not, spend 20 minutes debugging, and if you cannot solve the problem please send a message in the queue channel.

You might be thinking, “This was a lot of work to refactor this application. Might it have been easier just to rebuild it from scratch?” It might have been. This prompts two thoughts. Firstly, this demonstrates the importance of planning and understanding what you want to include in an app. Proper planning will often save you a lot of time coding. Secondly, it is still of immense benefit to have to refactor applications while learning. It helps you develop a better understanding of how data is moving around your app. Use refactoring opportunities for this purpose. It is also worth keeping in mind, if you are working on an app that is thousands of lines long you will most certainly not want to rebuild the whole application.

Going Further
You might have noticed that your Entry model includes a timestamp, but it has not been used anywhere. Update your EntryListTableViewController scene to have a style of right detail instead of basic. Update your EntryListTableViewController file to show the timestamp in the detail text view. Hint: Do some research on DateFormatter(), it can provide you some ways of turning a swift date into a nice looking string.

On your JournalListViewController, adjust the Create New Journal button to be grayed out and not selectable if the journalTitleTextField is empty.

Add support for tags on journals, add functionality to select a tag to display a list of entries with that tag.

Set the delegate relationship by adopting the UITextFieldDelegate protocol in the EntryDetailViewController class. Implement the delegate function textFieldShouldReturn and call the resignFirstResponder() method on the titleTextField to dismiss the keyboard.
