//
//  ModelManager.swift
//  SymptomTrackerIOS
//
//  Created by Kira Nim on 06/05/2022.
//

import Foundation

/* Responsibilities of the ModelManager:
 
The ModelManager manages business logic concerning model data that has been adapted to the system.
It manages the model-adapter classes (that takes care of CRUD).
Holds the model data classes adapted to be used throuhout the system.
Manages the Combine pipeline
 */

class ModelManager {
    
    private let symptomReposityry: SymptomRepository
    private let activityReposityry: ActivityRepository
    private let symptomRegistrationReposityry: SymptomRegistrationRepository
    private let intensityRegistrationReposityry: IntensityRegistrationRepository
    
    // Manages information about logged in user
    private let accountManager: AccountManager
    
    init() {
    symptomReposityry = SymptomRepository()
    activityReposityry = ActivityRepository()
    symptomRegistrationReposityry = SymptomRegistrationRepository()
    intensityRegistrationReposityry = IntensityRegistrationRepository()
    accountManager = AccountManager()
    }
}
