//
//  DateExtension.swift
//  The Movies
//
//  Created by Maul on 28/06/21.
//

import Foundation

extension Date
{
    func toString(eformat: DateFormatterStr) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = eformat.text
        formatter.timeZone = TimeZone.current
        return formatter.string(from: self)
    }
}

extension String
{
    func toDate(eformat: DateFormatterStr) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = eformat.text
        formatter.timeZone = TimeZone.current
        return formatter.date(from: self)
    }
    
    func convertDates() -> String? {
        return self.toDate(eformat: .api)?.toString(eformat: .dates)
    }
    
    func convertDayDates() -> String? {
        return self.toDate(eformat: .api)?.toString(eformat: .dayDate)
    }
}

// MARK:- DateFormatString
enum DateFormatterStr {
    case api
    case dates
    case dayDate
    
    var text: String {
        switch self {
        case .api: return "yyyy-MM-dd"
        case .dates: return "dd MMMM yyyy"
        case .dayDate: return "EEEE, dd MMMM yyy"
        }
    }
}
