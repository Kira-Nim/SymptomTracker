//
//  CalendarDateIntervalService.swift
//  SymptomTrackerIOS
//
//  Created by Kira Nim on 03/06/2022.
//

import Foundation

enum CalendarIntervalType: Int {
    case week = 0
    case month
    case year
}

class CalendarDateIntervalService {
    public func startAndEndDateOfIntervalFor(date: Date, intervalType: CalendarIntervalType) -> (Date, Date) {
        switch intervalType {
            case .week:
                let startDate = Calendar.current.dateComponents([.calendar, .yearForWeekOfYear, .weekOfYear], from: date).date ?? date
                let endDate = Calendar.current.date(byAdding: .day, value: 6, to: startDate) ?? date
                return (startDate, endDate)
            case .month:
                if let interval = Calendar.current.dateInterval(of: .month, for: date) {
                    let startDate = interval.start
                    let endDate = interval.end
                    return (startDate, endDate)
                }
            case .year:
                if let interval = Calendar.current.dateInterval(of: .year, for: date) {
                    let startDate = interval.start
                    let endDate = interval.end
                    return (startDate, endDate)
                }
        }
        return (date, date)
    }
}
