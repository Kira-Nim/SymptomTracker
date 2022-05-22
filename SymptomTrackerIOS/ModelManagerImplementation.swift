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
                                        weakPasswordError,
                                        emptyField }

public enum AccountLoginResult {case loginSucceded,
                                     logInCredentialsNotValid,
                                     failed,
                                     accountDisabled,
                                     emptyField,
                                     invalidEmail}

final class ModelManagerImplementation: ModelManager {
    
    // Repositories - Takes care of CRUD
    private lazy var symptomReposityry = SymptomRepository()
    private lazy var activityReposityry: ActivityRepository = ActivityRepository()
    private lazy var symptomRegistrationReposityry = SymptomRegistrationRepository()
    private lazy var intensityRegistrationReposityry = IntensityRegistrationRepository()
    
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
    
    //MARK: Create account functionality
    
    public func createNewAccountWith(email: String, password: String, showErrorMessageFor: @escaping (AccountCreationResult) -> Void) {
        
        accountManager.createAccountWith(email: email, password: password, createDefaultSymptomList: createDefaultSymptomListDatabase) { errorMessage in
            // "getCreationResult(..)" returns the enum value used to determine which error message
            //(if any) should be passed to the view from the VM
            showErrorMessageFor(self.getCreationResult(errorMessage: errorMessage))
        }
    }
    
    public func createDefaultSymptomListDatabase(user: String) {
        let defaultSymptomsNamesAndState = getDefaultSymptomNamesAndState()
        let count = 0
        for item in defaultSymptomsNamesAndState {
            
            let document: [String:Any] = [
                "name": item.0,
                "disabled": item.1,
                "visibility_On_Graph": false,
                "sorting_placement": count,
                "user_id": user]
            
            symptomReposityry.saveSymptomToDB(symptomDocument: document)
            count ++
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
    private func getDefaultSymptomNamesAndState() -> [(String, Bool)]{
        return [(LocalizedStrings.shared.headache, false),
                (LocalizedStrings.shared.neckPain, false),
                (LocalizedStrings.shared.dizziness, true),
                (LocalizedStrings.shared.nausea, true),
                (LocalizedStrings.shared.soundSensitivity, false),
                (LocalizedStrings.shared.lightSensitivity, true),
                (LocalizedStrings.shared.impairedVision, false),
                (LocalizedStrings.shared.jointPain, true),
                (LocalizedStrings.shared.pressureInTheHead, true),
                (LocalizedStrings.shared.ringingInTheHead, true),
                (LocalizedStrings.shared.overactiveNervousSystem, false),
                (LocalizedStrings.shared.muscleTension, true),
                (LocalizedStrings.shared.alcoholIntolerance, true),
                (LocalizedStrings.shared.extremeFatigue, true),
                (LocalizedStrings.shared.delayedFatigue, true),
                (LocalizedStrings.shared.quickExhaustion, true),
                (LocalizedStrings.shared.seizureFatigue, true),
                (LocalizedStrings.shared.stressFatigue, true),
                (LocalizedStrings.shared.alteredSleep, true),
                (LocalizedStrings.shared.insomnia, true),
                (LocalizedStrings.shared.hypersomnia, true),
                (LocalizedStrings.shared.stress, false),
                (LocalizedStrings.shared.difficultyPayingAttention, false),
                (LocalizedStrings.shared.learningDifficulties, true),
                (LocalizedStrings.shared.impairedVisionRegistration, true),
                (LocalizedStrings.shared.decisionFatigue, true),
                (LocalizedStrings.shared.slowThinking, true),
                (LocalizedStrings.shared.slowResponsiveness, false),
                (LocalizedStrings.shared.difficultyConcentrating, false),
                (LocalizedStrings.shared.reducedSensoryFilter, true),
                (LocalizedStrings.shared.memoryProblems, true),
                (LocalizedStrings.shared.difficultiesUsingTheWorkingMemory, false),
                (LocalizedStrings.shared.reducedExecutiveFunctions, true),
                (LocalizedStrings.shared.reducedReadinessForChange, true),
                (LocalizedStrings.shared.sadness, true),
                (LocalizedStrings.shared.severeAnxciety, true),
                (LocalizedStrings.shared.mildAnxciety, false),
                (LocalizedStrings.shared.irritability, false),
                (LocalizedStrings.shared.aggression, true),
                (LocalizedStrings.shared.moodChanges, false),
                (LocalizedStrings.shared.difficultyWithEmotionalControl, true),
                (LocalizedStrings.shared.changedPersonality, true)]
    }
}




