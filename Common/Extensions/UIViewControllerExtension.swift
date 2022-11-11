//
//  UIViewControllerExtension.swift
//  JokeApp
//
//  Created by Christian Martinez on 11/11/22.
//

import UIKit

import NVActivityIndicatorView

class UIViewControllerExtension: UIViewController {
    
    
    // MARK: -  Properties
    
    override var preferredStatusBarStyle: UIStatusBarStyle { return self.statusBarStyle }
    
    var statusBarStyle: UIStatusBarStyle = .default {
        didSet {
            guard self.statusBarStyle != oldValue else { return }
            self.setNeedsStatusBarAppearanceUpdate()
        }
    }
    

}


extension UIViewController {
    
    
    func showLoader(optSize: CGSize? = nil, optType: NVActivityIndicatorType? = nil, optColor: UIColor? = nil){
        let actData = ActivityData(
            size: (optSize ?? CGSize(width: 80, height: 80)),
            message: nil,
            messageFont: nil,
            messageSpacing: nil,
            type: (optType ?? .circleStrokeSpin),
            color: (optColor ?? .white),
            padding: nil,
            displayTimeThreshold: nil,
            minimumDisplayTime: nil,
            backgroundColor: UIColor.black.withAlphaComponent(0.50),
            textColor: nil
        )
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(actData, nil)
    }
    
    func hideLoader(){
        NVActivityIndicatorPresenter.sharedInstance.stopAnimating(nil)
    }
    
}

extension UIViewControllerExtension: UINavigationBarDelegate {
  
    
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }
}
