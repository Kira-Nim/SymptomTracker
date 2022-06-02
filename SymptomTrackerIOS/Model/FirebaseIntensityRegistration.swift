//
//  FirebaseIntensityRegistration.swift
//  SymptomTrackerIOS
//
//  Created by Kira Nim on 05/05/2022.
//

import Foundation

class FirebaseIntensityRegistration: IntensityRegistration {
    var intensity: Int?
    var timeOrder: Int
    
    init(timeOrder: Int) {
        self.timeOrder = timeOrder
    }
    
    // Initializer used when mapping from list in attribute on instance of registration from registration collection in db
    init(intensity: Int?, timeOrder: Int) {
        self.intensity = intensity
        self.timeOrder = timeOrder
    }
}
