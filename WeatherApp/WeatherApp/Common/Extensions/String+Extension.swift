//
//  String+Extension.swift
//  WeatherApp
//
//  Created on 04/09/25.
//

import Foundation

enum DateFormat: String {
    case yearMonthDayTime       = "yyyy-MM-dd HH:mm"
    case weekdayDayMonthYear    = "EEEE, dd MMM yy"
    case yearMonthDay           = "yyyy-MM-dd"
    case weekdayShort           = "EEE"
}

extension String {
    func convertDateFormat(fromFormat: DateFormat, toFormat: DateFormat) -> String? {
        let formatter = DateFormatter()
        formatter.dateFormat = fromFormat.rawValue
        guard let date = formatter.date(from: self) else {
            return nil
        }
        formatter.dateFormat = toFormat.rawValue
        return formatter.string(from: date)
    }
}
