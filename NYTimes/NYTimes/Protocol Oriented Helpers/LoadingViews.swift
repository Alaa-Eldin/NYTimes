//
//  LoadingViews.swift
//  NYTimes
//
//  Created by Alaa Eldin on 11/13/18.
//  Copyright © 2018 Alaa.Hamed. All rights reserved.
//

import UIKit

protocol Loadable {
    func showLoadingIndicator()
    func hideLoadingIndicator()
}

//TODO: I will do it when I have time
extension Loadable where Self: UIViewController {
//    let activityIndicator = UIac
}
