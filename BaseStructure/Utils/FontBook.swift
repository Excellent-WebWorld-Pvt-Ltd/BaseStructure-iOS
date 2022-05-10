//
//  FontBook.swift
//  FashionHouse
//
//  Created by Gaurang Vyas on 31/01/22.
//

import Foundation
import UIKit

class FontBook {
    
    enum FontWeight {
        case regular, medium, semibold, bold
    }
    
    static func font(ofSize fontSize: CGFloat, weight: FontWeight) -> UIFont {
        switch weight {
        case .regular:
            return UIFont.systemFont(ofSize: fontSize, weight: .regular)
           // return UIFont(name: "Poppins-Regular", size: fontSize)!
        case .medium:
            return UIFont.systemFont(ofSize: fontSize, weight: .medium)
           // return UIFont(name: "Poppins-Medium", size: fontSize)!
        case .bold:
            return UIFont.systemFont(ofSize: fontSize, weight: .bold)
          //  return UIFont(name: "Poppins-Bold", size: fontSize)!
        case .semibold:
            return UIFont.systemFont(ofSize: fontSize, weight: .semibold)
           // return UIFont(name: "Poppins-SemiBold", size: fontSize)!
        }
    }
}
