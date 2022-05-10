//
//  DateFormate+Extension.swift
//  Populaw
//
//  Created by Gaurang on 22/09/21.
//

import Foundation

enum DateFormatHelper: String {
    case fullDateTime   = "MM-dd-yyyy HH:mm"
    case fullDate       = "dd MMMM yyyy"
    case twentyHrTime   = "h:mma"
    case apiFormat      = "yyyy-MM-dd HH:mm:ss"
    case chatMessage    = "yyyy-MM-dd HH:mm"
    case year           = "yyyy"
    case dateOnly       = "yyyy-MM-dd"

    var dateFormatter: DateFormatter {
        let dateformat = DateFormatter()
        dateformat.locale = .current
        dateformat.dateFormat = self.rawValue
        return dateformat
    }

    func getDateString(from date: Date) -> String {
        return dateFormatter.string(from: date)
    }

    func getDate(from string: String) -> Date? {
        return dateFormatter.date(from: string)
    }

}
