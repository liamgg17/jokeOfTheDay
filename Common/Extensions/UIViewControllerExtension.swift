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
    
    
    func alertMessage(message: String, dismiss: Bool = true, completion: (()->())? = nil){
      
        let alert = UIAlertController(title: Bundle.appName(),
                                      message: message, preferredStyle: .actionSheet)
        if !dismiss {
            
            alert.addAction(UIAlertAction(title: "Ok",
                                          style: .default,
                                          handler: { (action) in
                                            if let xcompletion = completion {
                                                xcompletion()
                                            }
            }))
            
        }
        
        if let popoverPresentationController = alert.popoverPresentationController {
            popoverPresentationController.sourceView = self.view
            popoverPresentationController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
            popoverPresentationController.permittedArrowDirections = []
        }
        self.present(alert, animated: true, completion: nil)
        
        if dismiss {
            let when = DispatchTime.now() + 2.5
            DispatchQueue.main.asyncAfter(deadline: when){
                alert.dismiss(animated: true, completion: nil)
            }
        }
        
    }
    
}

extension UIViewControllerExtension: UINavigationBarDelegate {
  
    
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }
}

extension Bundle {
    static func appName() -> String {
        guard let dictionary = Bundle.main.infoDictionary else {
            return ""
        }
        if let version : String = dictionary["CFBundleName"] as? String {
            return version
        } else {
            return ""
        }
    }
}
