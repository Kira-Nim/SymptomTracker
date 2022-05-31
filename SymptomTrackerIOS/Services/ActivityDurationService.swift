//
//  ActivityDurationservice.swift
//  SymptomTrackerIOS
//
//  Created by Kira Nim on 30/05/2022.
//

import Foundation

class ActivityDurationService {
    
    public func getDurationStringForMinutes(_ numMinutes: Int) -> String {
        var hours = numMinutes / 60
        var minutes = numMinutes % 60
        return "Varighed: \(hours):\(minutes)"
    }
}
