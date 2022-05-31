//
//  ActivityDurationservice.swift
//  SymptomTrackerIOS
//
//  Created by Kira Nim on 30/05/2022.
//

import Foundation

class ActivityDurationService {
    
    public func getDurationStringForMinutes(_ numMinutes: Int) -> String {
        let hours = numMinutes / 60
        let minutes = numMinutes % 60
        return String(format: "Varighed: %d:%02d", hours, minutes)
    }
}
