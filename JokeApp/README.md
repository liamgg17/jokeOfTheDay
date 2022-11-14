# jokeOfTheDay
 
For the development of the project, the MVVM architecture was used, where for each contemplated module, the different layers of the application are used.

## Project

### Generalities

The project was designed to be developed with the greatest independence from third-party libraries, including the following general features:

* Dependencies (Swift Package Manager):
    * AlamoFire
    * NVActivityIndicatorView

It also includes the requested features.

* Requested features:
    * Consume the public API
    * Visualize the random joke
    * View included flags
    * Show refresh button
    * Show splashScreen
* Also:
    * General architecture: MVVM
    * Protocol Oriented Programming
    * Functional Programming


## Structure

Within the project we find the following structure:
* NetworkManager.swift: Responsible for handling network errors
* APISettings.swift: Contains the base URL for API
* Resources: This folder includes fonts used
* JokeRemoteDataManager: Responsible for making the request to the API
* Model:
    * JokeModel.swift.swift Contains the basic model of the Joke object. In turn, it has part of the responsibilities of the Model layer
*View:
    * Joke.storyboard : IB of the main screen view of the application connected to JokeViewController.swift
    * JokeViewController.swift It is the main view controller that connects with the ViewModel to present the information on the screen
*ViewModel:
    * JokeViewModel.swift Contains the MVVM viewModel layer, communicates with model and view


## How to use

* Clone the project
* Run the JokeApp.xcodeproj
* Reset package dependences (If necessary)
* Finally run the Build and Run app.


Compiled on Xcode 14.0.1 with Swift 5.7
