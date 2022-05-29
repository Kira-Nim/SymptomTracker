//
//  SymptomRegistration.swift
//  SymptomTrackerIOS
//
//  Created by Kira Nim on 05/05/2022.
//

import Foundation
import Firebase

class FirebaseSymptomRegistration: SymptomRegistration {
    var id: String?
    var date: Date
    var symptomId: String?
    var intensityRegistrations: [IntensityRegistration]
    var intensityRegistrationAverage: Int {
        var intensitySum: Int = 0
        for intensityRegistration in intensityRegistrations {
            intensitySum += intensityRegistration.intensity
        }
        return intensitySum/4
    }
    
    // initializer for when creating a new registration
    init(intensityRegistrationsSet: [FirebaseIntensityRegistration], symptomId: String) {
        self.date = Date()
        self.intensityRegistrations = intensityRegistrationsSet
        self.symptomId = symptomId
    }
    
    // Initializer used when mapping from registration collection in db
    init(firebaseSymptomRegistration: [String: Any], symptomRegistrationId: String) {
        
        // Default value is a safety precaution - It should never be used
        self.date = (firebaseSymptomRegistration["date"] as? Timestamp)?.dateValue() ?? Date()
        self.intensityRegistrations = firebaseSymptomRegistration["intensity_registrations"] as? [FirebaseIntensityRegistration] ?? []
        self.symptomId = firebaseSymptomRegistration["symptomId"] as? String
        self.id = symptomRegistrationId
    }
}
