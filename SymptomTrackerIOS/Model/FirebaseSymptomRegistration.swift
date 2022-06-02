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
    var symptomId: String
    var intensityRegistrationList: [IntensityRegistration]
    var intensityRegistrationAverage: Int? { return calculateIntensityAverageValue() }
    var symptom: Symptom?
    
    // initializer for when creating a new registration
    init(intensityRegistrationsSet: [FirebaseIntensityRegistration], symptomId: String) {
        self.date = Date()
        self.intensityRegistrationList = intensityRegistrationsSet
        self.symptomId = symptomId
    }
    
    // Initializer used when mapping from registration collection in db
    init(firebaseSymptomRegistration: [String: Any], symptomRegistrationId: String) {
        
        var intensityRegistrationList: [FirebaseIntensityRegistration] = []
        
        // If let here because the compiler needs reasurrence that the db object is infact a list of dictionaries
        if let intensityRegistrationDictList = firebaseSymptomRegistration["intensity_registrations"] as? [[String: Any]] {
            intensityRegistrationList = intensityRegistrationDictList.map {
                if let intensity = $0["intensity"] as? Int?, let timeOrder = $0["timeOrder"] as? Int {
                    let intensityRegistration = FirebaseIntensityRegistration(intensity: intensity, timeOrder: timeOrder)
                    return intensityRegistration
                }
                // This will never happen if data is properly stored in db. This insecuryty os an evil of a schemaless db solution
                return FirebaseIntensityRegistration(intensity: nil, timeOrder: -1)
            }
        }
        
        // Default value is a safety precaution - It should never be used
        self.id = symptomRegistrationId
        self.date = (firebaseSymptomRegistration["date"] as? Timestamp)?.dateValue() ?? Date()
        self.symptomId = firebaseSymptomRegistration["symptomId"] as? String ?? ""
        self.intensityRegistrationList = intensityRegistrationList
    }
    
    
    // Help-function for calculating an intensity level representing the average intensity value on a daily registration
    private func calculateIntensityAverageValue() -> Int? {
        var intensityLevel: Int?
        
        // Filter out all intensityRegistrations that have a nil intensity. Get a list of intensities.
        let intensityListWithoutNilValues = intensityRegistrationList.compactMap({
            $0.intensity
        })
        
        // Get sum of intensity
        var intensitySum: Int = 0
        intensityListWithoutNilValues.forEach({
            intensitySum += $0
        })

        // If intensityListWithoutNilValues is empty set the attribute to nil, else calculate an average.
        // Get average intensity based only on non-nil values of intensity.
        // If average is more than 0, and les than 1 then always round up. Else standard rounding pattern
        if intensityListWithoutNilValues.count != 0 {
            let intensityLevelDouble: Double = Double(intensitySum) / Double(intensityListWithoutNilValues.count)
            if (intensityLevelDouble > 0 && intensityLevelDouble <= 1 ) {
                intensityLevel = 1
            } else {
                intensityLevel = Int(round(intensityLevelDouble))
            }
        } else {
            intensityLevel = nil
        }
         return intensityLevel
    }
}
