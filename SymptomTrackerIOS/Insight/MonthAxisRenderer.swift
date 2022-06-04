//
//  MonthAxisRenderer.swift
//  SymptomTrackerIOS
//
//  Created by Kira Nim on 04/06/2022.
//

import Foundation
import Charts

class MonthAxisRenderer: XAxisRenderer {
    var overrideWithWeekInterval = false
    
    override func computeAxisValues(min: Double, max: Double) {
        if !overrideWithWeekInterval {
            super.computeAxisValues(min: min, max: max)
            return
        }
        let minDate = Date(timeIntervalSince1970: min)
        let maxDate = Date(timeIntervalSince1970: max)
        var baseLineDate = minDate
        guard let interval = Calendar.current.dateInterval(of: .weekOfYear, for: minDate) else { return }
        let startDate = interval.start
        
        if startDate >= minDate {
            baseLineDate = startDate
        } else {
            baseLineDate = Calendar.current.date(byAdding: .day, value: 7, to: startDate) ?? baseLineDate
        }
        var dates: [Date] = []
        var currentDate = baseLineDate
        while currentDate < maxDate {
            dates.append(currentDate)
            currentDate = Calendar.current.date(byAdding: .day, value: 7, to: currentDate) ?? maxDate
        }
        let values = dates.map { $0.timeIntervalSince1970 }

        axis.entries.removeAll(keepingCapacity: true)
        axis.entries.append(contentsOf: values)
                
        let n = values.count
        
        if axis.centerAxisLabelsEnabled
        {
            let interval = 7.0 * 24.0 * 60.0 * 60.0 // a week in seconds
            let offset: Double = interval / 2.0
            axis.centeredEntries = axis.entries[..<n]
                .map { $0 + offset }
        }
        
        computeSize()
    }
}
