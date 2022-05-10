//
//  Singleton.swift
//  Virtuwoof Pet
//
//  Created by EWW80 on 09/11/19.
//  Copyright © 2019 EWW80. All rights reserved.
//

import Foundation
import UIKit

class Helper: NSObject {

    var deviceToken = String()
    
    static var keyWindow: UIWindow? {
            // Get connected scenes
        if #available(iOS 13.0, *) {
            return UIApplication.shared.connectedScenes
            // Keep only active scenes, onscreen and visible to the user
                .filter { $0.activationState == .foregroundActive }
            // Keep only the first `UIWindowScene`
                .first(where: { $0 is UIWindowScene })
            // Get its associated windows
                .flatMap({ $0 as? UIWindowScene })?.windows
            // Finally, keep only the key window
                .first(where: \.isKeyWindow)
        } else {
            return UIApplication.shared.keyWindow
        }
    }
    
    static var topSafeAreaHeight: CGFloat {
        return keyWindow?.safeAreaInsets.top ?? 0
    }

    static var bottomSafeAreaHeight: CGFloat {
        return keyWindow?.safeAreaInsets.bottom ?? 0
    }

    static var appVersion: String {
        let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        return version ?? ""
    }

    static var apiLogEnabled = true

    static func randomString(length: Int) -> String {
      let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
      return String((0..<length).map { _ in letters.randomElement()! })
    }

    static var userId: String {
        return SessionManager.shared.userId ?? ""
    }

    static var screenSize: CGSize {
        UIScreen.main.bounds.size
    }
    
    static var appName: String {
        Bundle.main.displayName ?? "Populaw"
    }

    static var deviceHasTopNotch: Bool {
        (AppDelegate.current?.window?.safeAreaInsets.top ?? 0) > 20
    }

    static var deviceType = "ios"

}

extension Bundle {
    var displayName: String? {
        return object(forInfoDictionaryKey: "CFBundleDisplayName") as? String
    }
}
