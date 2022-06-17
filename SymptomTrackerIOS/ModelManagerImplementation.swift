//
//  ModelManager.swift
//  SymptomTrackerIOS
//
//  Created by Kira Nim on 06/05/2022.
//

import Foundation
import SwiftUI

/* Responsibilities of the ModelManager:
The ModelManager manages business logic concerning model data that has been adapted to the system.
It manages the model-adapter classes (that takes care of CRUD).
Holds the model data classes adapted to be used throuhout the system.
 */


final class ModelManagerImplementation: ModelManager {
    
    //MARK: Repositories
    private let symptomRepository: SymptomRepository
    private let activityRepository: ActivityRepository
    private let symptomRegistrationRepository: SymptomRegistrationRepository
    private let intensityRegistrationRepository: IntensityRegistrationRepository
    
    //MARK: Other attributes
    
    // All symptoms for loggedin user
    private var firebaseSymptoms: [FirebaseSymptom] = []
    // Manages information about logged in user
    private let accountManager: AccountManager
    
    // An object of type Name containing a notification name that can be croadcast.
    public let symptomsUpdatedNotificationName = NSNotification.Name("SymptomsUpdatedNotification")
    
    //MARK: Init
    init() {
        symptomRepository = SymptomRepository()
        activityRepository = ActivityRepository()
        symptomRegistrationRepository = SymptomRegistrationRepository()
        intensityRegistrationRepository = IntensityRegistrationRepository()
        accountManager = AccountManager()
        
        // If the user is still logged in then the snapshot listener should be started.
        if let userId = self.accountManager.loggedInUserId {
            self.symptomRepository.startListener(loggedInUser: userId)
        }
        
        // Always register callback, even if we don't fetch the symptoms immediately (we'll still need it after logging in)
        // When the symptom list is updated in the symptomsRepository, then this callback will be run and the symptomslist here will be updated. further more it will be broadcasted that everyone else should update their symptomslist as well.
        self.symptomRepository.callbacks.append(updateFirebaseSymptomList)
    }

    // MARK: UpdateFirebaseSymptomList()
    public func updateFirebaseSymptomList() {
        
        // Update attribute "firebaseSymptoms" to contain the same list as the list of the same name in symptomRepository.
        firebaseSymptoms = symptomRepository.firebaseSymptoms
        
        // Notify everyone that is registrered to be notified that symptoms has been updated.
        /*
         NotificationCenter is a class made available in the Foundation framework.
         There is a singleton stored in a variable called "default"
         
         NotificationCenter acts as a central middle man between all other classes that might be interested in registrering notifications and all classes that would be interested in listening for notifications. It is a broad casting center.
         
         A notification must have a "name" og type NSNotification.Name "Name" is essentialy a wrapper around a String.
         
         When listening for at breadcast a class must first register that it will be listening on a notification og a given "name"
         
         --> Pattern Pub-sub (publish and subscribe)
         
         object can be used to send extra context data to the listeners when broadcasting a notification.
        */
        NotificationCenter.default.post(name: symptomsUpdatedNotificationName, object: nil)
    }
    
    // MARK: isUserLoggedIn()
    public func isUserLoggedIn() -> Bool {
        return accountManager.isLoggedIn
    }
    
    // MARK: Symptom CRUD

    // Function for gerring a list of all symptoms for logged in user
    public func getSymptoms() -> [Symptom] {
        var symptomList: [Symptom] = firebaseSymptoms
        
                                                        // For testing purposes
                                                        for item in symptomList {
                                                            print(item.sortingPlacement)
                                                        }
        symptomList.sort {
            $0.sortingPlacement < $1.sortingPlacement
        }
        return symptomList
    }
    
    // Update symptom that has been edited
    public func updateSymptom(symptom: Symptom) {
        if let firebaseSymptom = symptom as? FirebaseSymptom {
            symptomRepository.update(symptom: firebaseSymptom)
        }
    }
    
    // for updating more than one symptom that has been edited
    public func updateSymptoms(symptoms: [Symptom]) {
        // use compactMap to cast all symptoms from Symptom to FirebaseSymptom before sending them to be saved in db.
        let firebaseSymptoms = symptoms.compactMap({ $0 as? FirebaseSymptom })
        symptomRepository.updateSymptoms(symptoms: firebaseSymptoms)
    }
    
    // For deleting symptom
    public func delete(symptom: Symptom) {
        if let firebaseSymptom = symptom as? FirebaseSymptom {
            symptomRepository.delete(symptom: firebaseSymptom)
        }
    }
    
    // For creating a new symptom with a given sortingPlacement
    public func createSymptom(sortingPlacement: Int) -> Symptom? {
        if let userId = accountManager.loggedInUserId  {
            return FirebaseSymptom(sortingPlacement: sortingPlacement, userId: userId)
        } else {
            return nil
        }
    }
    
    // MARK: CRUD for Activities
    
    // for updating an activity in db
    public func update(activity: Activity) {
        if let firebaseActivity = activity as? FirebaseActivity, let userId = accountManager.loggedInUserId {
            activityRepository.updateActivity(firebaseActivity: firebaseActivity, userId: userId)
        }
    }
    
    // For updating a list of activities in db
    public func update(activities: [Activity]) {
        if let userId = accountManager.loggedInUserId{
            // use compactMap to cast all activities from Activity to Firebaseactivity before saving them to db
            let firebaseActivities = activities.compactMap({ $0 as? FirebaseActivity })
            activityRepository.updateActivities(activities: firebaseActivities, userId: userId)
        }
    }
    
    // For creating a new activity
    public func createActivity(date: Date) -> Activity? {
        if let userId = accountManager.loggedInUserId {
            return FirebaseActivity(userId: userId, date: date)
        } else {
            return nil
        }
    }
    
    // For deleting an activity from db
    public func delete(activity: Activity) {
        if let firebaseActivity = activity as? FirebaseActivity {
            activityRepository.delete(activity: firebaseActivity)
        }
    }
    
    // For getting list of activities for a given date.
    // The activities will be delivered to the caller of this function when the callback given as param in the call to this method is run. It is run inside another callback given as param to a function call to a method on the activityRepository.
    public func getActivitiesForDate(date: Date,
                                     getActivitiesForDateCompletionCallback: @escaping (([Activity]) -> Void)) {

        if let userId = accountManager.loggedInUserId {
            activityRepository.getActivitiesFor(date: date, userId: userId) { firebaseActivityList in
                
                // Creating a new list because the firebaseActivityList is imutable (let)
                let newFirebaseList = firebaseActivityList.sorted {
                    $0.date > $1.date
                }
                getActivitiesForDateCompletionCallback(newFirebaseList)
            }
        }
    }
    
    // For getting list of activities for a given interval of dates.
    public func getActivitiesForInterval(startDate: Date,
                                         endDate: Date,
                                         getActivitiesForIntervalCompletionCallback: @escaping (([Activity]) -> Void)) {

        if let userId = accountManager.loggedInUserId {
            activityRepository.getActivitiesForInterval(startDate: startDate, endDate: endDate, userId: userId) { firebaseActivityList in
                
                // Creating a new list because the firebaseActivityList is imutable (let)
                let newFirebaseList = firebaseActivityList.sorted {
                    $0.date > $1.date
                }
                getActivitiesForIntervalCompletionCallback(newFirebaseList)
            }
        }
    }
    
    // MARK: CRUD for Registrations
    
    // Get all registrations for a given date.
    public func getRegistrationsForDate(date: Date,
                                        getRegistrationsForDateCompletionCallback: @escaping (([SymptomRegistration]) -> Void)) {
        
        // RegistrationService is used to prerare the symptoms-registrations in the symptomRegistrationsList.
        let registrationsService = RegistrationService()
        
        // If user is not logged in - should never happen
        if let userId = accountManager.loggedInUserId {
            
            symptomRegistrationRepository.getSymptomRegistrationsForDate(date: date, userId: userId) { firebaseSymptomRegistrationList in
                
                // Only save registrations for non-disabled symptoms
                let enabledSymptoms = self.firebaseSymptoms.filter { !$0.disabled }
                
                // registrationsService will return a list that has one registration for each symptom. If a registration does not exist in firebaseSymptomregistrationList, then a fresh registration will be generated and added to symptomRegistrationList.
                let symptomRegistrationsList = registrationsService.getSymptomRegistrationListFrom(
                                                        firebaseSymptomRegistrationList: firebaseSymptomRegistrationList,
                                                        symptomList: enabledSymptoms,
                                                        date: date)
                
                // Run callback passed from symptomRegistrationViewModel
                getRegistrationsForDateCompletionCallback(symptomRegistrationsList)
            }
        }
    }
    
    // function for getting all registrations in a time interval
    public func getRegistrationsForInterval(startDate: Date,
                                            endDate: Date,
                                            getRegistrationsForIntervalCompletionCallback: @escaping (([SymptomRegistration]) -> Void)) {
        // RegistrationService is used to prerare the symptoms-registrations in the symptomRegistrationsList.
        let registrationsService = RegistrationService()
        
        // If user is not logged in - should never happen
        if let userId = accountManager.loggedInUserId {
            
            symptomRegistrationRepository.getSymptomRegistrationsForInterval(startDate: startDate, endDate: endDate, userId: userId) { firebaseSymptomRegistrationList in
                
                // Only save registrations for non-disabled symptoms
                let enabledSymptoms = self.firebaseSymptoms.filter { !$0.disabled }
                
                // registrationsService will return a list that has one registration for each symptom. If a registration does not exist in firebaseSymptomregistrationList, then a fresh registration will be generated and added to symptomRegistrationList.
                let symptomRegistrationsList = registrationsService.connectSymptonsAndRegistrations(
                    firebaseSymptomRegistrationList: firebaseSymptomRegistrationList,
                    symptomList: enabledSymptoms)
                
                // Run callback passed from symptomRegistrationViewModel
                getRegistrationsForIntervalCompletionCallback(symptomRegistrationsList)
            }
        }
    }
    
    // Update/save symptomRegistraytion to database.
    public func updateRegistration(symptomRegistration: SymptomRegistration) {
        if let firebaseSymptomRegistration = symptomRegistration as? FirebaseSymptomRegistration, let userId = accountManager.loggedInUserId {
            
            symptomRegistrationRepository.updateSymptomRegistration(firebaseSymptomRegistration: firebaseSymptomRegistration, userId: userId)
        }
    }
}

//MARK: Extension - AccountModelManager

// For logic concerning login/logout and create account
extension ModelManagerImplementation: AccountModelManager {
    
    //MARK: Create account
    
    public func createNewAccountWith(email: String, password: String, showErrorMessageFor: @escaping (AccountCreationResult) -> Void) {
        accountManager.createAccountWith(email: email, password: password) { errorMessage in
            // "getCreationResult(..)" returns the enum value used to determine which error message
            //(if any) should be passed to the view from the VM
            showErrorMessageFor(self.getCreationResult(errorMessage: errorMessage))
            
            if let loggedInUserId = self.accountManager.loggedInUserId {
                self.createDefaultSymptomListForDatabase(user: loggedInUserId)
                self.symptomRepository.startListener(loggedInUser: loggedInUserId)
            }
        }
    }
    
    public func createDefaultSymptomListForDatabase(user: String) {
        let defaultSymptomsNamesAndState = getDefaultSymptomNamesAndState()
                
        for (index, item) in defaultSymptomsNamesAndState.enumerated() {
            let document: [String:Any] = [
                "name": item.0,
                "disabled": item.1,
                "visibility_On_Graph": false,
                "sorting_placement": index,
                "user_id": user]
            
            symptomRepository.saveSymptomToDB(symptomDocument: document)
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
        
    //MARK: Login
    
    // Method for logging in user.
    public func loginWith(email: String, password: String, showErrorMessageFor: @escaping (AccountLoginResult) -> Void) {
        
        accountManager.loginWith(email: email, password: password) { errorMessage in
            showErrorMessageFor(self.getLoginResult(errorMessage: errorMessage))
            
            // "loggedInUserId" is a computed property that returns the user that is registred as loggedin in Firebase auth.
            if let userId = self.accountManager.loggedInUserId {
                self.symptomRepository.startListener(loggedInUser: userId)
            }
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
                (LocalizedStrings.shared.lightSensitivity, false, true),
                (LocalizedStrings.shared.extremeFatigue, false, true),
                (LocalizedStrings.shared.neckPain, false, false),
                (LocalizedStrings.shared.soundSensitivity, false, false),
                (LocalizedStrings.shared.impairedVision, false, false),
                (LocalizedStrings.shared.overactiveNervousSystem, false, false),
                (LocalizedStrings.shared.difficultyConcentrating, false, false),
                (LocalizedStrings.shared.mildAnxciety, true, false),
                (LocalizedStrings.shared.difficultiesUsingTheWorkingMemory, true, false),
                (LocalizedStrings.shared.difficultyPayingAttention, true, false),
                (LocalizedStrings.shared.moodChanges, true, false),
                (LocalizedStrings.shared.irritability, true, false),
                (LocalizedStrings.shared.slowResponsiveness, true, false),
                (LocalizedStrings.shared.stress, true, false),
                (LocalizedStrings.shared.dizziness, true, false),
                (LocalizedStrings.shared.nausea, true, false),
                (LocalizedStrings.shared.jointPain, true, false),
                (LocalizedStrings.shared.pressureInTheHead, true, false),
                (LocalizedStrings.shared.ringingInTheHead, true, false),
                (LocalizedStrings.shared.muscleTension, true, false),
                (LocalizedStrings.shared.alcoholIntolerance, true, false),
                (LocalizedStrings.shared.delayedFatigue, true, false),
                (LocalizedStrings.shared.quickExhaustion, true, false),
                (LocalizedStrings.shared.seizureFatigue, true, false),
                (LocalizedStrings.shared.stressFatigue, true, false),
                (LocalizedStrings.shared.alteredSleep, true, false),
                (LocalizedStrings.shared.insomnia, true, false),
                (LocalizedStrings.shared.hypersomnia, true, false),
                (LocalizedStrings.shared.learningDifficulties, true, false),
                (LocalizedStrings.shared.impairedVisionRegistration, true, false),
                (LocalizedStrings.shared.decisionFatigue, true, false),
                (LocalizedStrings.shared.slowThinking, true, false),
                (LocalizedStrings.shared.reducedSensoryFilter, true, false),
                (LocalizedStrings.shared.memoryProblems, true, false),
                (LocalizedStrings.shared.reducedExecutiveFunctions, true, false),
                (LocalizedStrings.shared.reducedReadinessForChange, true, false),
                (LocalizedStrings.shared.sadness, true, false),
                (LocalizedStrings.shared.severeAnxciety, true, false),
                (LocalizedStrings.shared.aggression, true, false),
                (LocalizedStrings.shared.difficultyWithEmotionalControl, true, false),
                (LocalizedStrings.shared.changedPersonality, true, false)]
    }
}




