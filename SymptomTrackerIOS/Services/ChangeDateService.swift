//
//  ChangeDateService.swift
//  SymptomTrackerIOS
//
//  Created by Kira Nim on 02/06/2022.
//

import Foundation

class ChangeDateService {
    
    public func changeToSelectedDate(chosenDate: Date, currentlySelectedDate: Date, lists: [String: [SymptomRegistration]]) {
        
        
        guard let selectedDateRegistrations = lists["selectedDateRegistrations"],
              let nextDateRegistrations = lists["nextDateRegistrations"],
              let previousDateRegistrations = lists["previousDateRegistrations"] else {return}
        
        
        
        guard let previousToCurrentDate = Calendar.current.date(byAdding: .day, value: -1, to: currentlySelectedDate),
              let nextToCurrentDate = Calendar.current.date(byAdding: .day, value: 1, to: currentlySelectedDate) else {return}
        
        if chosenDate == nextToCurrentDate {

            
        } else if chosenDate == previousToCurrentDate {
            
        } else {
            
        }
    }
}
