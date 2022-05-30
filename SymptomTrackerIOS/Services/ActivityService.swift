//
//  ActivityService.swift
//  SymptomTrackerIOS
//
//  Created by Kira Nim on 30/05/2022.
//

import Foundation
import UIKit

class ActivityService {
    
    // Function for getting list of symptomregistrations for a day.
    // If registrations on symptoms does not exist. they will be created.
    // The registration list will be ordered the same way the symptom list is.
    func getSymptomRegistrationListFrom(firebaseActivityList: [FirebaseActivity], activityList: [FirebaseActivity]) -> [Activity] {
        
        var activities: [Activity] = []
        
        return activities
    }
}
