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

/*
 Calender is a class in the Swift library (foundation)
 
 Case week:
     "Calendar.current" -> Current is the calender type that the phone is confugured to be using.
     "dateComponents" -> is a method that is used to generate an object of type DateComponents.
    There is made a datecomponent based on the date given as last param. From this dateComponent we create a date representing start date.
 
     The array params that is given to dateComponent contains a set of enums representing the data that you want to extract from the dateComponent later.
    The dateComponent is made based on the last param from: date.
 
    Array params
     1) .calender -> what calender is the basis for the Date class
     2) .yearForWeekOfYear -> what year does this "weekOfYear" belong to (because the last and the first week of a year (when transitioning) can be one week)
     3) .weekOfYear -> what week number
        ".date" will return the start date of the dateComponent
 
 case month:
    ".dateInterval" is a function that takes a date and an enum. the enum id information of the size of the interval and the date is the date around whitch the month is.
 
 case year:
    Not used but still available for later.
 */
class CalendarDateIntervalService {
    
    // Function that will return the date of the first and last day i choosen interval calculated based on a given date.
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
