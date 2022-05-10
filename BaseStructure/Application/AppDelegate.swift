//
//  AppDelegate.swift
//  BaseStructure
//
//  Created by Gaurang on 28/04/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    // MARK: - Variables
    static var current: AppDelegate? {
        UIApplication.shared.delegate as? AppDelegate
    }
    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        configureUI()
        print("API URL: ", AppEnvironment.apiUrl)
        return true
    }
}
