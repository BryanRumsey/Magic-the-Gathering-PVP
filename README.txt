Bryan Rumsey
March 7, 2019
Computer Science: Computer Systems
Senior Project
Magic the Gathering PVP

<--- Instructions for Running Magic the Gathering PVP --->

1.) Open Finder and go to the Magic the Gathering PVP project folder
2.) Open the Magic the Gathering PVP.xcworkspace
		NOTE: If you open the project through Xcode instead of Finder
			  Xcode will fill not be able to locate the Firebase libraries.
3.) Once the project is open click on the drop down just to the left of the 
	status bar in the center and select the simulator to run the program on.
		NOTE: The project was built to fit the iPhone 5s to ensure that it 
			  will run on any of the standard simulators
4.) Click the run button at the top of Xcode to build and run the apllication.
5.) You can use the video tutorials to test each component of the app.



<------------------ Contract Deviations ----------------->

	<-------- Task that weren't implemented -------->
	 1.) Task 6 will no longer be implemented.
	 2.) Task 7 will no longer be implemented.
	 3.) Task 12 will no longer be implemented as stated.
	 4.) Task 16 will no longer be implemented as stated.

	<-- Tasks that were altered form the contract -->
	 1.) Reset Password
		 --> User will enter their username to validate the user account.
		 --> User will recieve an email with a link to reset the password.
		 --> User can follow the link and enter a new password.
		 --> When the user submits the new password their account is updated.
	 2.) Login -- Invalid Username should be Login -- No Existing Account Error
	 The Chat Room task was split into two tasks.
	 3.) Chat Room -- Post Message
		 --> The user can type a message into the message box
		 --> When the user taps on the post message button the message is posted to the chat.
	 4.) Chat Room -- Display All Messages
		 --> The messages from every user is displayed in the chat room.

	<----- Tasks that werem't in the contract ------>
	 1.) Login -- Invalid Email Error
		 --> If the user doesn't enter an email for the username display an error messgae.
	 2.) Reset Password -- Invalid Email Error
		 --> If the user doesn't enter an email for the username display an error messgae.
	 3.) Create Account -- Invalid Email Error
		 --> If the user doesn't enter an email for the username display an error messgae.
	 4.) Create Account -- Password Requirement Error
		 --> If the user enters a password that is less than eight characters long
			display an error message.
	 5.) Collection
		 --> Display all of the users collections
	 6.) Collection -- View Contents
		 --> The user can click on a collection
		 --> The contents of the collection are displayed below with the collection name.
	 7.) Collection -- Create Library
		 --> An add library image is displayed at the end of the users collections.
		 --> The user can tap on this image
		 --> When the user taps on the image they are directed to the manage library screen.
	 8.) Collection -- Edit Library
	 	 --> An edit library button will appear if the user taps on a collection other than
	 	 	 the Card Box.
	 	 --> When the user taps on the edit library button they are redirected to the manage
	 	 	 library screen.
	 	 --> The name of the selected library is sent to the manage library screen.
	 9.) Collection -- Delete Library
		 --> A delete libraty button will appear if the user taps on a collection other than
			the Card Box.
		 --> When the user taps on the button the library is removed from the database and the
			list of the users collections.
	10.) Manage Library -- Create Library
		 --> The user will be prompted to enter a name for their library.
		 --> The contents on the users card box will be displayed with the name of the new 
		 	 library below them
		 --> If the user already has a library with that name the contents of the existing 
		 	 library are displayed with the library name below the Card Box.
	11.) Manage Library -- Edit Library
		 --> The name of the library is recieved from the collection screen
		 --> The contents of the users Card Box, the name of the library, and the contents 
		 	 of the library are displayed.
	12.) Manage Library -- Cancel
		 --> If the user taps on the cancel button the library is removed from the database.
		 --> The user is redirected to the Collections screen.
	13.) Manage Library -- Create Library -- Prompt For Library Name
		 --> When the user enters for the name the create library button is activated.
		 --> If the user deletes all of the text in the library name field the create library
		 	 button is disabled.
		 --> If the user taps on the create library button the name that was entered is passed
		 	 to the screen.
		 --> If the user taps on the cancel button the prompt will close and the user will be
		 	 redirected to the Collection screen.
	14.) Manage Library -- Add Lands
		 --> The add library button will appear when at least one card is in the library.
		 --> When the add library button is tapped prompt will appear asking for the number 
		 	 of each type of land they wish to add to the library.
	15.) Manage Library -- Save Library
		 --> When the save library button is pressed user wil be redirected to the collection 
		 	 screen and the new library will appear in the collection.
	16.) Manage Library -- Add Lands -- Prompt for Lands
		 --> The user will be able to enter the number of each type of land they wish to add.
		 --> When the all of the data fields are filled the a number the add lands button will 
		 	 display.
		 --> If the user enters a letter in any of the fiels the add lands button will remain 
		 	 disabled until the letter is removed.
		 --> if the contents of any of the text fields are deleted the add lands button will
		 	 be disabled.
		 --> When the user taps on the add lands button the lands the user entered are added 
		 	 to the database for that library, the prompt is closed, and the lands will appear
		 	 with the other cards in the library.
		 --> When the user taps on the cancel button the prompt will close.
	17.) Manage Library -- Add Non-Land Card To Library
		 --> If a player taps on a card in the Card Box the card will be added to the library 
		 	 and removed from the card box.
	18.) Manage Library -- Remove Card From Library
		 --> If a player taps on a card in the library the card will be removed from the library.
		 --> If the card is not a basic land it will be added to the Card Box.
		 --> If the card is a basic land it will not be added to the card box.
	19.) Preserve Cards After Deletion
		 --> When the user deletes a library all of the cards that were in that library are 
			moved back into the Card Box with the exception of Basic Lands.
	20.) Import Card -- Card Prompt
		 --> The user is prompted to enter the name of the card that they wish to add.
		 --> If the user enters a name the add card button is enabled
		 --> id the user deletes the name the add card button is diabled
	21.) Import Card -- Card Prompt -- Buttons
		 --> When the user taps the add card button the database is searched for the card name.
		 --> When the user taps the Cancel button the prompt is closed.
	22.) Import Card -- Card Found
		 --> If the card is found it is added to the users Card Box and the prompt closed.
	23.) Import Card -- Card Not Found
		 --> If the card is not found an alert informs the user that the card is not available.
		 --> The user is also asked is they would like to request that the card be added.
	24.) Import Card -- Card Not Found -- Request Alert
		 --> If the user taps yes a request is posted for admin users to view.
		 ADMIN FEATURES NOT IMPLEMENTED YET
		 --> If the user taps no the alert is closed.
	25.) Import Card -- Character Recognition
		 --> NOT IMPLEMENTED YET