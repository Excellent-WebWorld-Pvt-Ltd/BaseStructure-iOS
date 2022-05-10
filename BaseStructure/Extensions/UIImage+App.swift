//
//  UIImage+App.swift
//  BaseStructure
//
//  Created by Gaurang on 29/04/22.
//

import Foundation
import UIKit

enum AppImages: String {
    case placeholder
    case profilePlaceholder = "placeholder_man"
}

extension UIImage {
    convenience init?(appImage: AppImages) {
        self.init(named: appImage.rawValue)
    }
}
