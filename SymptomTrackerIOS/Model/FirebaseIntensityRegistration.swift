//
//  FirebaseIntensityRegistration.swift
//  SymptomTrackerIOS
//
//  Created by Kira Nim on 05/05/2022.
//

import Foundation

class FirebaseIntensityRegistration: IntensityRegistration {
    var intensity: Int
    var timeOrder: Int
    
    init(timeOrder: Int) {
        self.intensity = 0
        self.timeOrder = timeOrder
    }
    
    init(firebaseIntensityRegistration: [String: Any]) {
        
        // Default value is a safety precaution - It should never be used
        self.intensity = firebaseIntensityRegistration["intensity"] as? Int ?? 0
        self.timeOrder = firebaseIntensityRegistration["timeOrder"] as? Int ?? -1
    }
}
