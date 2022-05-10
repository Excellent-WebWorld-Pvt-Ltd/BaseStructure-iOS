//
//  UIView+Extension.swift
//  Danfo_Rider
//
//  Created by Hiral Jotaniya on 24/06/21.
//

import Foundation
import UIKit

extension UIView {

    func clipToCircle() {
        clipsToBounds = true
        layer.cornerRadius = bounds.width / 2
    }

    func clipToCapsule(hasBorder: Bool) {
        self.clipsToBounds = true
        self.layer.cornerRadius = self.frame.height / 2
        if hasBorder {
            self.layer.borderWidth  = 1.0
            self.layer.borderColor  = UIColor.blue.cgColor
        }
    }

    func setAllSideContraints(_ insets: UIEdgeInsets) {
        guard let view = superview else {
            return
        }
        topAnchor.constraint(equalTo: view.topAnchor, constant: insets.top).isActive = true
        leftAnchor.constraint(equalTo: view.leftAnchor, constant: insets.left).isActive = true
        rightAnchor.constraint(equalTo: view.rightAnchor, constant: insets.right).isActive = true
        bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: insets.bottom).isActive = true
    }

    func setAllSideContraintsFromSafeArea(_ insets: UIEdgeInsets) {
        guard let view = superview else {
            return
        }
        topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: insets.top).isActive = true
        leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: insets.left).isActive = true
        rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: insets.right).isActive = true
        bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: insets.bottom).isActive = true
    }

    func setCenterToViewContraints() {
        guard let view = superview else {
            return
        }
        centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }

    func updateConstraint(attribute: NSLayoutConstraint.Attribute, constant: CGFloat) {
        if let constraint = (self.constraints.filter {$0.firstAttribute == attribute}.first) {
            constraint.constant = constant
            self.layoutIfNeeded()
        }
    }
}

extension UIButton {
    func setTitleWithoutAnimation(_ text: String) {
        UIView.performWithoutAnimation {
            setTitle(text, for: .normal)
        }
    }
}
