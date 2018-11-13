//
//  RootWireframe.swift
//  AlFuttaim_News
//
//  Created by Alaa Eldin on 11/9/18.
//  Copyright © 2018 Alaa.Hamed. All rights reserved.
//

import UIKit

class RootWireframe {
    var newsFeedWireframe:NewsFeedWireframe!
    
    func rootNavigationController()-> UINavigationController {
        if newsFeedWireframe == nil {
            newsFeedWireframe = NewsFeedWireframe()
        }
        return newsFeedWireframe.moduleNavigationController
    }
}

