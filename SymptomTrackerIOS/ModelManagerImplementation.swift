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

final class ModelManagerImplementation: ModelManager {
    
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
    public func isUserLoggedIn() -> Bool {
        return accountManager.isLoggedIn
    }
}

//MARK: ModelManager Extension

// For logic concerning login/logout and create account
extension ModelManagerImplementation: AccountModelManager {
    
    //MARK: Create account functionality
    public func createNewAccountWith(email: String, password: String, showErrorMessageFor: @escaping (AccountCreationResult) -> Void) {
        accountManager.createAccountWith(email: email, password: password) { errorMessage in
            // "getCreationResult(..)" returns the enum value used to determine which error message
            //(if any) should be passed to the view from the VM
            showErrorMessageFor(self.getCreationResult(errorMessage: errorMessage))
            
            if let loggedInUserId = self.accountManager.loggedInUserId {
                self.createDefaultSymptomListDatabase(user: loggedInUserId)
            }
        }
    }
    
    public func createDefaultSymptomListDatabase(user: String) {
        let defaultSymptomsNamesAndState = getDefaultSymptomNamesAndState()
        var count = 0
        for item in defaultSymptomsNamesAndState {
            
            let document: [String:Any] = [
                "name": item.0,
                "disabled": item.1,
                "visibility_On_Graph": false,
                "sorting_placement": count,
                "user_id": user]
            
            symptomReposityry.saveSymptomToDB(symptomDocument: document)
            count += 1
        }
    }
    
    // Method for translating error message (and nill) to enum "ErrorIdentifyer"
    public func getCreationResult(errorMessage: String?) -> AccountCreationResult {
        let errorMappingDict: [String: AccountCreationResult] = [
                "ERROR_INVALID_EMAIL": .invalidEmail,
                "ERROR_EMAIL_ALREADY_IN_USE": .emailAlreadyExist,
                "ERROR_WEAK_PASSWORD": .weakPasswordError]
        
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
                "ERROR_USER_NOT_FOUND": .logInCredentialsNotValid,
                "ERROR_WRONG_PASSWORD": .logInCredentialsNotValid,
                "ERROR_INVALID_EMAIL": .logInCredentialsNotValid,
                "ERROR_USER_DISABLED": .accountDisabled]
        
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
    
    //MARK: Reset password functionality
    
    public func resetPassword(email: String) {
        accountManager.resetPassword(email: email)
    }
    
    //MARK: get default symptom tuples list
    
    private func getDefaultSymptomNamesAndState() -> [(String, Bool, Bool)]{
        return [(LocalizedStrings.shared.headache, false, true),
                (LocalizedStrings.shared.neckPain, false, false),
                (LocalizedStrings.shared.dizziness, true, false),
                (LocalizedStrings.shared.nausea, true, false),
                (LocalizedStrings.shared.soundSensitivity, false, false),
                (LocalizedStrings.shared.lightSensitivity, false, true),
                (LocalizedStrings.shared.impairedVision, false, false),
                (LocalizedStrings.shared.jointPain, true, false),
                (LocalizedStrings.shared.pressureInTheHead, true, false),
                (LocalizedStrings.shared.ringingInTheHead, true, false),
                (LocalizedStrings.shared.overactiveNervousSystem, false, false),
                (LocalizedStrings.shared.muscleTension, true, false),
                (LocalizedStrings.shared.alcoholIntolerance, true, false),
                (LocalizedStrings.shared.extremeFatigue, false, true),
                (LocalizedStrings.shared.delayedFatigue, true, false),
                (LocalizedStrings.shared.quickExhaustion, true, false),
                (LocalizedStrings.shared.seizureFatigue, true, false),
                (LocalizedStrings.shared.stressFatigue, true, false),
                (LocalizedStrings.shared.alteredSleep, true, false),
                (LocalizedStrings.shared.insomnia, true, false),
                (LocalizedStrings.shared.hypersomnia, true, false),
                (LocalizedStrings.shared.stress, false, false),
                (LocalizedStrings.shared.difficultyPayingAttention, false, false),
                (LocalizedStrings.shared.learningDifficulties, true, false),
                (LocalizedStrings.shared.impairedVisionRegistration, true, false),
                (LocalizedStrings.shared.decisionFatigue, true, false),
                (LocalizedStrings.shared.slowThinking, true, false),
                (LocalizedStrings.shared.slowResponsiveness, false, false),
                (LocalizedStrings.shared.difficultyConcentrating, false, false),
                (LocalizedStrings.shared.reducedSensoryFilter, true, false),
                (LocalizedStrings.shared.memoryProblems, true, false),
                (LocalizedStrings.shared.difficultiesUsingTheWorkingMemory, false, false),
                (LocalizedStrings.shared.reducedExecutiveFunctions, true, false),
                (LocalizedStrings.shared.reducedReadinessForChange, true, false),
                (LocalizedStrings.shared.sadness, true, false),
                (LocalizedStrings.shared.severeAnxciety, true, false),
                (LocalizedStrings.shared.mildAnxciety, false, false),
                (LocalizedStrings.shared.irritability, false, false),
                (LocalizedStrings.shared.aggression, true, false),
                (LocalizedStrings.shared.moodChanges, false, false),
                (LocalizedStrings.shared.difficultyWithEmotionalControl, true, false),
                (LocalizedStrings.shared.changedPersonality, true, false)]
    }
}




