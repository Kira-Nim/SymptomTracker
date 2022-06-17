//
//  MonthAxisRenderer.swift
//  SymptomTrackerIOS
//
//  Created by Kira Nim on 04/06/2022.
//

import Foundation
import Charts

// This class has been implemented because we need to costumize how the x-axix is shown when month is selected
// This is a subclass and not an extention because we need to create properties and not just functionality.

class MonthAxisRenderer: XAxisRenderer {
    
    // Public variable created to distinguish between the graph showing a week or month interval on the x-axis when this method is accesed. If week then the method on the parent class will be called ("super.computeAxisValues"), else this costumization will be accesed.
    
    // About naming - override with month interval sections. Meaning interval sections showing a week in month-x-axix-graph-mode.
    var overrideWithWeekInterval = false
    
    // Function to be used every time the view is loaded and the graph is made anew.
    // This function is called from the Chart "system" not us.
    override func computeAxisValues(min: Double, max: Double) {
        
        // If default mode for Charts
        if !overrideWithWeekInterval {
            super.computeAxisValues(min: min, max: max)
            return
        }
        
        // Variables containing date calculated on the basis of num sec sinth 1970 up to given date (Double) represented as min or max here.
        let minDate = Date(timeIntervalSince1970: min)
        let maxDate = Date(timeIntervalSince1970: max)
        
        // Step 1: calculate baselinedate where the first interval-section-line should be drawn
        
        // The number represenring the place on the graph where we want the first line to be.
        // Beseline because it is from this place/number that all the following lines placement will be calculated.
        var baseLineDate = minDate
        
        // ".dateInterval" will return a date-interval containing a start and end date that represents the week in which the given date lies.
        guard let interval = Calendar.current.dateInterval(of: .weekOfYear, for: minDate) else { return }
        // The first date in interval (should be a monday in danish calender and sunday in american calender)
        let startDate = interval.start
        
        // Change baseline date to be the first day (monday) in the week of the baseline date.
        // (> is not strickly nssesary here)
        // Brainfart here --> if = then the two date will already be the same date...
        if startDate >= minDate {
            baseLineDate = startDate
        } else {
            baseLineDate = Calendar.current.date(byAdding: .day, value: 7, to: startDate) ?? baseLineDate
        }
        
        // Step 2: Add all the dates to an list. The dates each representing a interval-section-line-placement on graph
        
        var dates: [Date] = []
        var currentDate = baseLineDate
        while currentDate < maxDate {
            dates.append(currentDate)
            currentDate = Calendar.current.date(byAdding: .day, value: 7, to: currentDate) ?? maxDate
        }
        
        // Step 3: Convert the dates in the list to Double values that can be mapped on the graph by the Chart "system".
        let values = dates.map { $0.timeIntervalSince1970 }

        // Step 4: append date to be shown on axix
        
        // entries is a property on the axis property on this class instance.
        // "keepingCapacity" mini optimization -> keep the memory. dont dealocate. Uou will get new date right away.
        axis.entries.removeAll(keepingCapacity: true)
        axis.entries.append(contentsOf: values)
               
        // 5: adjust porsition of labels on x-axis
        
        let n = values.count
        
        // "centerAxisLabelsEnabled" proporty for setting the labels between lines.
        
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
