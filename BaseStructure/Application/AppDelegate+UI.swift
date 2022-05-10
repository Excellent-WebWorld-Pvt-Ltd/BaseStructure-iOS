//
//  AppDelegate+UI.swift
//  Populaw
//
//  Created by Gaurang on 17/02/22.
//

import UIKit
import IQKeyboardManagerSwift

// MARK: App Theme Stuff
extension AppDelegate {

    func configureUI() {
        window = UIWindow(frame: UIScreen.main.bounds)
        // window?.tintColor = .themePrimary
        setupKeyboardManager()
        if #available(iOS 13, *) {
            window?.overrideUserInterfaceStyle = .light
        }
        setRootViewController()
        window?.makeKeyAndVisible()
    }

    private func setupKeyboardManager() {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
    }

    func setRootViewController() {
        if SessionManager.shared.isLoggedIn {
            window?.rootViewController = UINavigationController(rootViewController: Router.movieList.instance)
        } else {
            let loginVC = Router.login.instance
            window?.rootViewController = UINavigationController(rootViewController: loginVC)
        }
    }

    func setRootViewController(_ viewController: UIViewController) {
        window?.rootViewController = viewController
    }
}
