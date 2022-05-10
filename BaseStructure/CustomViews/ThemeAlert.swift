//
//  ThemeAlert.swift
//  FashionHouse
//
//  Created by Gaurang Vyas on 31/01/22.
//

import UIKit

class ThemeAlertView: NSObject {
    static func show(title: String? = nil, message: String? = nil, actions: [UIAlertAction] = [.okAction]) {
        let viewCtr = UIAlertController(title: title, message: message, preferredStyle: .alert)
        actions.forEach({
            viewCtr.addAction($0)
        })
        UIApplication.topViewController()?.present(viewCtr, animated: true)
    }
}

extension UIAlertAction {
    static var okAction: UIAlertAction {
        UIAlertAction(title: StringConsts.okay, style: .cancel)
    }
}
