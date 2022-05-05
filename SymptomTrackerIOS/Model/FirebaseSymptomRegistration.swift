//
//  SymptomRegistration.swift
//  SymptomTrackerIOS
//
//  Created by Kira Nim on 05/05/2022.
//

import Foundation
import Firebase

class FirebaseSymptomRegistration: SymptomRegistration {
    
    var date: Date
    var intensityRegistrations: [IntensityRegistration]
    var intensityRegistrationAverage: Int {
        var intensitySum: Int = 0
        for intensityRegistration in intensityRegistrations {
            intensitySum += intensityRegistration.intensity
        }
        return intensitySum/4
    }
    
    init(intensityRegistrationsSet: [FirebaseIntensityRegistration]) {
        self.date = Date()
        self.intensityRegistrations = intensityRegistrationsSet
    }
    
    init(firebaseSymptomRegistration: [String: Any]) {
        
        // Default value is a safety precaution - It should never be used
        self.date = (firebaseSymptomRegistration["date"] as? Timestamp)?.dateValue() ?? Date()
        self.intensityRegistrations = firebaseSymptomRegistration["intensity_registrations"] as? [FirebaseIntensityRegistration] ?? []
    }
}
