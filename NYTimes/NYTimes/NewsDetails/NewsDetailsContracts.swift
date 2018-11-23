//
//  NewsDetailsContracts.swift
//  NYTimes
//
//  Created by Alaa Eldin on 11/13/18.
//  Copyright © 2018 Alaa.Hamed. All rights reserved.
//

// VIPER Interface to the Module
protocol NewsDetailsDelegate: class {
}

// VIPER Interface for communication from Interactor -> Presenter
protocol NewsDetailsInteractorToPresenterInterface: class {
}

// VIPER Interface for communication from View -> Presenter
protocol NewsDetailsViewToPresenterInterface: class {
    func viewDidLoad()
}

// VIPER Interface for communication from Wireframe -> Presenter
protocol NewsDetailsWireframeToPresenterInterface: class {
    var delegate: NewsDetailsDelegate? { get }
    func set(delegate newDelegate: NewsDetailsDelegate?)
}
// VIPER Interface for communication from Presenter to Interactor
protocol NewsDetailsPresenterToInteractorInterface: class {
}
// VIPER Module Constants
struct NewsDetailsConstants {
    // Uncomment to utilize a navigation contoller from storyboard
    //static let navigationControllerIdentifier = "NewsDetailsNavigationController"
    static let storyboardIdentifier = "NewsDetails"
    static let viewIdentifier = "NewsDetailsView"
}

// Interface Abstraction for working with the VIPER Module
protocol NewsDetails: class {
    var delegate: NewsDetailsDelegate? { get set }
}

// VIPER Interface for communication from Presenter -> Wireframe
protocol NewsDetailsPresenterToWireframeInterface: class {
}

// VIPER Interface for manipulating the navigation of the view
protocol NewsDetailsNavigationInterface: class {
}

// VIPER Interface for communication from Presenter -> View
protocol NewsDetailsPresenterToViewInterface: class {
    func showNewsImageFrom(imageURL: String)
    func showNewsTitle(title: String)
    func showNewsDetails(newsDetails: String)
}
