//
//  Date+Ext.swift
//  NewsFeed
//
//  Created by Bikash Agarwal on 21/03/20.
//  Copyright © 2020 Bikash Agarwal. All rights reserved.
//

import Foundation

extension String {
    func ConvertToDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = .current
        return dateFormatter.date(from: self)
    }
    
    func ConvertToDisplayFormat() -> String {
        guard let date = self.ConvertToDate() else { return "N/A" }
        return date.ConvertToYearMonthFormat()
    }
    
    func ConvertDays(from: Int) -> String {
        let date = Calendar.current.date(byAdding: .day, value: -from, to: Date())
        return date!.ConvertToYearMonthFormat()
    }
}

extension Date {
    func ConvertToYearMonthFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: self)
    }
}
