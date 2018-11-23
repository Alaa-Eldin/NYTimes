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

extension Loadable where Self: UIViewController {
    func showLoadingIndicator() {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.frame = CGRect(x: 0.0, y: 0.0, width: 40.0, height: 40.0)
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style =
            UIActivityIndicatorView.Style.gray
        self.view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }
    func hideLoadingIndicator() {
        for view in self.view.subviews where view is UIActivityIndicatorView {
            (view as? UIActivityIndicatorView)?.stopAnimating()
            view.removeFromSuperview()
        }
    }
}
