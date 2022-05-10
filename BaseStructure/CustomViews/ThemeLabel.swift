//
//  Themes.swift
//  Danfo_Rider
//
//  Created by Hiral Jotaniya on 15/03/21.

import UIKit

enum TextColor {
    case black, gray, primary, white
    
    var color: UIColor {
        switch self {
        case .black:
            return .black
        case .gray:
            return .gray
        case .primary:
            return .blue
        case .white:
            return .white
        }
    }
}

class ThemeLabel: UILabel {

    @IBInspectable var fontSize: CGFloat = 16
    
    @IBInspectable var regular: Bool = false
    @IBInspectable var medium: Bool = false
    @IBInspectable var semiBold: Bool = false
    @IBInspectable var bold: Bool = false
    
    @IBInspectable var blackColor: Bool = false
    @IBInspectable var primaryColor: Bool = false
    @IBInspectable var gray: Bool = false
    @IBInspectable var darkGray: Bool = false
    @IBInspectable var white: Bool = false

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setViews()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setViews()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setViews()
    }

    convenience init(fontSize: CGFloat, fontWeight: FontBook.FontWeight, color: TextColor) {
        self.init()
        self.setAppearance(fontSize: fontSize, fontWeight: fontWeight, textColor: color)
    }
    
    func setViews() {
        var fontWeight = FontBook.FontWeight.regular
        if regular {
            fontWeight = .regular
        } else if medium {
            fontWeight = .medium
        } else if semiBold {
            fontWeight = .semibold
        } else if bold {
            fontWeight = .bold
        }
        var color: TextColor = .black
        if blackColor {
            color = .black
        } else if primaryColor {
            color = .primary
        } else if gray {
            color = .gray
        } else if white {
            color = .white
        }
        setAppearance(fontSize: fontSize, fontWeight: fontWeight, textColor: color)
    }
    
    func setAppearance(fontSize: CGFloat, fontWeight: FontBook.FontWeight, textColor: TextColor) {
        self.font = FontBook.font(ofSize: fontSize, weight: fontWeight)
        self.textColor = textColor.color
    }
}
