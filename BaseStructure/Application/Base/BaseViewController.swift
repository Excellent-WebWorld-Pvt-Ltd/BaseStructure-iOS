//
//  BaseViewController.swift
//  Router
//
//  Created by Gaurang on 27/04/22.
//

import UIKit

class BaseViewController: UIViewController {

    private var proccessIndicator: UIActivityIndicatorView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func showLoading() {
        proccessIndicator = UIActivityIndicatorView(style: .large)
        proccessIndicator?.frame.size = .init(width: 100, height: 100)
        guard let proccessIndicator = proccessIndicator else {
            return
        }
        view.addSubview(proccessIndicator)
        proccessIndicator.center = view.center
        proccessIndicator.startAnimating()
    }
    
    func hideLoading() {
        proccessIndicator?.removeFromSuperview()
        proccessIndicator = nil
    }
    
    func showAlertMessage(_ message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(.init(title: "Ok", style: .default))
        self.present(alert, animated: true)
    }
    
    func showErrorMessage(_ error: String, onRetry: EmptyClosure?) {
        if onRetry != nil {
            let retryAction = UIAlertAction(title: StringConsts.retry, style: .default) { _ in
                
            }
            ThemeAlertView.show(title: StringConsts.alert, message: error, actions: [retryAction, .okAction])
        } else {
            ThemeAlertView.show(title: Helper.appName, message: error)
        }
    }

}
