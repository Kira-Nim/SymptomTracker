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
    
    private let symptomAdapter: SymptomAdapter
    private let activityAdapter: ActivityAdapter
    private let symptomRegistrationAdapter: SymptomRegistrationAdapter
    private let intensityRegistrationAdapter: IntensityRegistrationAdapter
    
    // Manages information about logged in user
    private let accountManager: AccountManager
    
    init() {
    symptomAdapter = SymptomAdapter()
    activityAdapter = ActivityAdapter()
    symptomRegistrationAdapter = SymptomRegistrationAdapter()
    intensityRegistrationAdapter = IntensityRegistrationAdapter()
    accountManager = AccountManager()
    }
}
