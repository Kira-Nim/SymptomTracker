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

public enum AccountCreationResult { case repeatPasswordFailed,
                                         failed,
                                         emailAlreadyExist,
                                         userCreated,
                                         invalidEmail,
                                         weakPasswordError }

class ModelManagerImplementation: ModelManager {
    
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

    public func createNewAccountWith(email: String, password: String, showErrorMessageFor: @escaping (AccountCreationResult) -> Void) {
        
        accountManager.createAccountWith(email: email, password: password) { errorMessage in
            self.createUserCompletionCallback(errorMessage: errorMessage, showErrorMessageFor: showErrorMessageFor)
        }
    }
    
    // Method used in callback - for translating error message (and nill) to enum "ErrorIdentifyer"
    // which is used in callback for showing error messages if needed (which comes from CreateAccountViewModel)
    public func createUserCompletionCallback(errorMessage: String?, showErrorMessageFor: (AccountCreationResult) -> Void) {
            
        switch (errorMessage) {
            case "FIRAuthErrorCodeInvalidEmail":
                showErrorMessageFor(.invalidEmail)
                
            case "FIRAuthErrorCodeEmailAlreadyInUse":
                showErrorMessageFor(.emailAlreadyExist)
                
            case "FIRAuthErrorCodeWeakPassword":
                showErrorMessageFor(.weakPasswordError)
            
            case nil:
                showErrorMessageFor(.userCreated)
                
            default:
                showErrorMessageFor(.failed)
        }
    }
}






