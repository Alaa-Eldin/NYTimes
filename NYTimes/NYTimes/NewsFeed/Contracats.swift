//
//  Contracats.swift
//  AlFuttaim_News
//
//  Created by Alaa Eldin on 11/9/18.
//  Copyright © 2018 Alaa.Hamed. All rights reserved.
//


// Interface Abstraction for working with the VIPER Module
protocol NewsFeed: class {
    var delegate: NewsFeedDelegate? { get set }
}

// VIPER Interface for communication from Presenter to Interactor
protocol NewsFeedPresenterToInteractorInterface: class {
    func fetchNewsFeedForPeriod(period:NewsPeriod, section:String)
}

// VIPER Interface for communication from Presenter -> Wireframe
protocol NewsFeedPresenterToWireframeInterface: class {
    
}

// VIPER Interface to the Module
protocol NewsFeedDelegate: class {
    
}

// VIPER Interface for communication from Interactor -> Presenter
protocol NewsFeedInteractorToPresenterInterface: class {
    func fetchNewsFailedWithError(fetchError:NewsFeedFetchError)
    func fetchNewsSuccess(newsFeedEntity:NewsFeedEntity)
}

// VIPER Interface for communication from View -> Presenter
protocol NewsFeedViewToPresenterInterface: class {
    func viewDidLoad()
}

// VIPER Interface for communication from Wireframe -> Presenter
protocol NewsFeedWireframeToPresenterInterface: class {
    var delegate: NewsFeedDelegate? { get }
    func set(delegate newDelegate: NewsFeedDelegate?)
}

// VIPER Interface for manipulating the navigation of the view
protocol NewsFeedNavigationInterface: class {
    
}

// VIPER Interface for communication from Presenter -> View
protocol NewsFeedPresenterToViewInterface: class {
    
}
