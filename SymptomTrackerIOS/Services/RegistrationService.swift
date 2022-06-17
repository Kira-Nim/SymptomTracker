//
//  RegistrationService.swift
//  SymptomTrackerIOS
//
//  Created by Kira Nim on 29/05/2022.
//

import Foundation


class RegistrationService {
    
    // Function for preparing a list of symptomregistrations for one day.
    // If registrations on symptoms does not exist. they will be created.
    // The registration list will be ordered the same way the symptom list is.
    func getSymptomRegistrationListFrom(firebaseSymptomRegistrationList: [FirebaseSymptomRegistration], symptomList: [FirebaseSymptom], date: Date) -> [SymptomRegistration] {
    
        var symptomRegistrations: [SymptomRegistration] = []
        
        // Create a dictionnary where element keys are symptomId on sympTomRegistration and values are symptomRegistrations
        // Created for the purpose of checking that there is an registration for each symptom in symptomList
        var firebaseSymptomRegistrationsDict: [String: FirebaseSymptomRegistration] = [:]
        firebaseSymptomRegistrationList.forEach({
            firebaseSymptomRegistrationsDict[$0.symptomId] = $0
        })
        
        /*
         Iterate through all symptoms and create a new FirebaseSymptomRegistration instance
         if there is no registrations on given symptom.
         Cast all FirebaseSymptomRegistrations to Symptomregistrations and append them to
         symptomRegistrations
         */
        symptomList.forEach({
            if let firebaseSymptomId = $0.id {
                if let firebaseSymptomRegistration = firebaseSymptomRegistrationsDict[firebaseSymptomId] {
                    firebaseSymptomRegistration.symptom = $0
                    symptomRegistrations.append(firebaseSymptomRegistration)
                    
                } else {
                    let intensityRegistrationsSet: [FirebaseIntensityRegistration] = createNewIntensityRegistrationList()
                    let newFirebaseSymptomRegistration = FirebaseSymptomRegistration(
                                                        intensityRegistrationsSet: intensityRegistrationsSet,
                                                        symptomId: firebaseSymptomId,
                                                        date: date)
                    newFirebaseSymptomRegistration.symptom = $0
                    symptomRegistrations.append(newFirebaseSymptomRegistration)
                }
            }
        })
        return symptomRegistrations
    }
    
    // Function for connecting list of registrations with their symptoms - setting symptoms on symptomRegistration instances in list.
    // The registration list will be ordered the same way the symptomList is.
    func connectSymptonsAndRegistrations(firebaseSymptomRegistrationList: [FirebaseSymptomRegistration], symptomList: [FirebaseSymptom]) -> [SymptomRegistration] {
        
        // Dictionary to look up a Symptom based on its Id (so we can match up registartions with their symptoms)
        // Creating a dictionary using a constructor for at Dictionary that takes a list of tupples as param. Using named parameter called "uniqueKeysWithValues". The map function is used to convert the list of symptoms to a list of tuples.
        let symptomsDict: [String: FirebaseSymptom] = Dictionary(uniqueKeysWithValues: symptomList.map{ ($0.id ?? "", $0) })
        
        var result: [FirebaseSymptomRegistration] = []
        for registration in firebaseSymptomRegistrationList {
            if let symptom = symptomsDict[registration.symptomId] {
                registration.symptom = symptom
                result.append(registration)
            }
        }
        return result
    }
    
    // Create list containing 4 new intensity instances
    func createNewIntensityRegistrationList() -> [FirebaseIntensityRegistration] {
        var firebaseIntensityRegistrationList: [FirebaseIntensityRegistration] = []

        for number in (0...3){
            let firebaseIntensityRegistration = FirebaseIntensityRegistration(intensity: nil, timeOrder: number)
            firebaseIntensityRegistrationList.append(firebaseIntensityRegistration)
        }
        return firebaseIntensityRegistrationList
    }
}
