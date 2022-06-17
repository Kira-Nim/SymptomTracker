//
//  ReplacementLineChartDataSet.swift
//  SymptomTrackerIOS
//
//  Created by Kira Nim on 03/06/2022.
//

import UIKit
import Charts

/* BUG WORKAROUND based on https://github.com/danielgindi/Charts/issues/4605
   Problem:
   When using a line chart if the x axis has its maximum value set above the largest value in the data set the chart will not render.
*/

class ReplacementLineChartDataSet: LineChartDataSet {
    override func entryIndex(x xValue: Double, closestToY yValue: Double, rounding: ChartDataSetRounding) -> Int {
        var closest = partitioningIndex { $0.x >= xValue }
        guard closest < endIndex else { return endIndex - 1 }

        let closestXValue = self[closest].x

        switch rounding {
        case .up:
            // If rounding up, and found x-value is lower than specified x, and we can go upper...
            if closestXValue < xValue && closest < index(before: endIndex)
            {
                formIndex(after: &closest)
            }

        case .down:
            // If rounding down, and found x-value is upper than specified x, and we can go lower...
            if closestXValue > xValue && closest > startIndex
            {
                formIndex(before: &closest)
            }

        case .closest:
            break
        }

        // Search by closest to y-value
        if !yValue.isNaN
        {
            while closest > startIndex && self[index(before: closest)].x == closestXValue
            {
                formIndex(before: &closest)
            }

            var closestYValue = self[closest].y
            var closestYIndex = closest

            while closest < index(before: endIndex)
            {
                formIndex(after: &closest)
                let value = self[closest]

                if value.x != closestXValue { break }
                if abs(value.y - yValue) <= abs(closestYValue - yValue)
                {
                    closestYValue = yValue
                    closestYIndex = closest
                }
            }

            closest = closestYIndex
        }
        
        return closest
    }
}
