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

public enum AccountCreationResult {case repeatPasswordFailed,
                                         failed,
                                         emailAlreadyExist,
                                         userCreated,
                                         invalidEmail,
                                         weakPasswordError}

public enum AccountLoginResult {case loginSucceded,
                                      logInCredentialsNotValid,
                                      failed,
                                      accountDisabled}

class ModelManagerImplementation: ModelManager {
    
    // Repositories - Takes care of CRUD
    private let symptomReposityry: SymptomRepository
    private let activityReposityry: ActivityRepository
    private let symptomRegistrationReposityry: SymptomRegistrationRepository
    private let intensityRegistrationReposityry: IntensityRegistrationRepository
    
    // Manages information about logged in user
    private let accountManager: AccountManager
    
    
    //MARK: Init
    init() {
        symptomReposityry = SymptomRepository()
        activityReposityry = ActivityRepository()
        symptomRegistrationReposityry = SymptomRegistrationRepository()
        intensityRegistrationReposityry = IntensityRegistrationRepository()
        accountManager = AccountManager()
    }

    //MARK Get logged in user
    public func getLoggedInUser() -> String? {
        return accountManager.loggedInUserId
    }
    
    //MARK: Create account functionality
    
    public func createNewAccountWith(email: String, password: String, showErrorMessageFor: @escaping (AccountCreationResult) -> Void) {
        
        accountManager.createAccountWith(email: email, password: password) { errorMessage in
            // "getCreationResult(..)" returns the enum value used to determine which error message
            //(if any) should be passed to the view from the VM
            showErrorMessageFor(self.getCreationResult(errorMessage: errorMessage))
        }
    }
    
    // Method for translating error message (and nill) to enum "ErrorIdentifyer"
    public func getCreationResult(errorMessage: String?) -> AccountCreationResult {
        
        let errorMappingDict: [String: AccountCreationResult] = [
                "FIRAuthErrorCodeInvalidEmail": .invalidEmail,
                "FIRAuthErrorCodeEmailAlreadyInUse": .emailAlreadyExist,
                "FIRAuthErrorCodeWeakPassword": .weakPasswordError]
        
        if let errorMessage = errorMessage {
            let creationResult = errorMappingDict[errorMessage] ?? .failed
            return creationResult
        }else {
            return .userCreated
        }
    }
    
    //MARK: Login functionality
    
    public func loginWith(email: String, password: String, showErrorMessageFor: @escaping (AccountLoginResult) -> Void) {
        
        // "getLoginResult(..)" returns the enum value used to determine which error message
        // (if any) should be passed to the view from the VM
        accountManager.loginWith(email: email, password: password) { errorMessage in
            showErrorMessageFor(self.getLoginResult(errorMessage: errorMessage))
        }
    }
    
    public func getLoginResult(errorMessage: String?) -> AccountLoginResult {
        let errorMappingDict: [String: AccountLoginResult] = [
                "FIRAuthErrorCodeWrongPassword": .logInCredentialsNotValid,
                "FIRAuthErrorCodeInvalidEmail": .logInCredentialsNotValid,
                "FIRAuthErrorCodeUserDisabled": .accountDisabled]
        
        if let errorMessage = errorMessage {
            let loginResult = errorMappingDict[errorMessage] ?? .failed
            return loginResult
        }else {
            return .loginSucceded
        }
    }
    
    //MARK: Logout functionality
    
    public func logOut(logOutCompletionCallback: (() -> Void)?) {
        accountManager.logOut(logOutCompletionCallback: logOutCompletionCallback)
    }
    
    //MARK Reset password functionality
    
    public func resetPassword(email: String) {
        accountManager.resetPassword(email: email)
    }
}




