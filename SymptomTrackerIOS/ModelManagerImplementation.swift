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

    public func getLoggedInUser() -> String? {
        return accountManager.loggedInUserId
    }
    
    public func createNewAccountWith(email: String, password: String, showErrorMessageFor: @escaping (AccountCreationResult) -> Void) {
        
        accountManager.createAccountWith(email: email, password: password) { errorMessage in
            // "getCreationResultCallback(..)" returns the enum value used to determine which error message
            //(if any) should be passed to the view from the VM
            showErrorMessageFor(self.getCreationResult(errorMessage: errorMessage))
        }
    }
    
    // Method for translating error message (and nill) to enum "ErrorIdentifyer"
    public func getCreationResult(errorMessage: String?) -> AccountCreationResult {
        
        let errorMappingDict: [String: AccountCreationResult] = [ "FIRAuthErrorCodeInvalidEmail": .invalidEmail,
                                 "FIRAuthErrorCodeEmailAlreadyInUse": .emailAlreadyExist,
                                 "FIRAuthErrorCodeWeakPassword": .weakPasswordError]
        
        if let errorMessage = errorMessage {
            let creationResult = errorMappingDict[errorMessage] ?? .failed
            return creationResult
            
        }else{
            return .userCreated
        }
    }
}






