//
//  ThemeAnimatedButton.swift
//  Populaw
//
//  Created by Gaurang on 08/12/21.
//

import Foundation
import UIKit

class ThemeAnimatedButton: UIButton {
    var activityIndicator: UIActivityIndicatorView?
    var originalButtonText: String?

    var indicatorColor: UIColor = .themePrimary

    func showLoading() {
        isEnabled = false
        originalButtonText = self.titleLabel?.text

        self.setTitle("", for: .normal)
        if activityIndicator == nil {
            activityIndicator = createActivityIndicator()
        }
        showSpinning()
    }

    func hideLoading() {
        isEnabled = true
        self.setTitle(originalButtonText, for: .normal)
        activityIndicator?.stopAnimating()
    }

    private func createActivityIndicator() -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = indicatorColor
        return activityIndicator
    }

    private func showSpinning() {
        guard let activityIndicator = self.activityIndicator else {
            return
        }
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(activityIndicator)
        centerActivityIndicatorInButton()
        activityIndicator.startAnimating()
    }

    private func centerActivityIndicatorInButton() {
        activityIndicator?.setCenterToViewContraints()
    }
}
