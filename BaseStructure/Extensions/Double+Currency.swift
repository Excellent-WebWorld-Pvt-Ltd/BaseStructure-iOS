//
//  Double+Currency.swift
//  Populaw
//
//  Created by Gaurang on 11/03/22.
//

import Foundation

extension Double {
    func toCurrencyFormate(locale: String?) -> String {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        currencyFormatter.minimumFractionDigits = 0
        currencyFormatter.maximumFractionDigits = 16
        currencyFormatter.currencyCode = locale ?? "usd"
        let priceString = currencyFormatter.string(from: NSNumber(value: self))!
        return priceString
    }
}
