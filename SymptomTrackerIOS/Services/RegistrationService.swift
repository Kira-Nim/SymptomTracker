//
//  RegistrationService.swift
//  SymptomTrackerIOS
//
//  Created by Kira Nim on 29/05/2022.
//

import Foundation

class RegistrationService {
    
    func GetSymptomRegistrationListFrom(firebaseSymptomRegistrationList: [FirebaseSymptomRegistration], symptomList: [FirebaseSymptom]) -> [SymptomRegistration] {
    
        var symptomRegistrations: [SymptomRegistration] = []
        
        // Create a dictionnary where element keys are symptomId on sympTomRegistration and values are sympTomRegistrations
        // Created for the purpose of checking that there is an registration for each symptom in symptomList
        var firebaseSymptomRegistrationsDict: [String: FirebaseSymptomRegistration] = [:]
        firebaseSymptomRegistrationList.forEach({
            if let symptomIdOnRegistration = $0.symptomId {
                firebaseSymptomRegistrationsDict[symptomIdOnRegistration] = $0
            }
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
                    let symptomRegistration: SymptomRegistration = firebaseSymptomRegistration as SymptomRegistration
                    symptomRegistrations.append(symptomRegistration)
                    
                } else {
                    let intensityRegistrationsSet: [FirebaseIntensityRegistration] = []
                    let newFirebaseSymptomRegistration = FirebaseSymptomRegistration(
                                                        intensityRegistrationsSet: intensityRegistrationsSet,
                                                        symptomId: firebaseSymptomId)
                    
                    let symptomRegistration: SymptomRegistration = newFirebaseSymptomRegistration as SymptomRegistration
                    symptomRegistrations.append(symptomRegistration)
                }
            }
        })
        
        return symptomRegistrations
    }
    
    func createNewIntensityRegistrationList(){
        
    }
}
