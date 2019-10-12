//
//  AppDelegate.swift
//  NYTimes
//
//  Created by Alaa Eldin on 11/11/18.
//  Copyright © 2018 Alaa.Hamed. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var rootWireframe: RootWireframe!

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)
        rootWireframe = RootWireframe()
        window?.makeKeyAndVisible()
        window?.rootViewController = rootWireframe.rootNavigationController()
        return true
    }
}
