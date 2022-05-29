//
//  SymptomRegistrationAdapter.swift
//  SymptomTrackerIOS
//
//  Created by Kira Nim on 06/05/2022.
//

import Foundation
import Firebase

final class SymptomRegistrationRepository {
    
    // variable containing collection name for registrations collection i firebase.
    let registrationCollection = "registrations"
    
    // Reference to database
    let db = Firestore.firestore()

    func getSymptomRegistrationsForDate(date: Date, userId: String) -> [FirebaseSymptomRegistration] {
        var firebaseRegistrations: [FirebaseSymptomRegistration] = []
        db.collection(registrationCollection).whereField("userId", isEqualTo: userId).whereField("date", isEqualTo: date).getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        let documentId = document.documentID
                        let symptomRegistrationDocument = document.data()
                        let firebaseSymptomRegistration = FirebaseSymptomRegistration(firebaseSymptomRegistration: symptomRegistrationDocument, symptomRegistrationId: documentId)
                        firebaseRegistrations.append(firebaseSymptomRegistration)
                    }
                }
        }
        return firebaseRegistrations
    }
    
    // Functopn for updating or saving symptom registration to db
    func updateSymptomRegistration(firebaseSymptomRegistration: FirebaseSymptomRegistration, userId: String) {
        
        let registrationDict: [String: Any] = prepareSymptomRegistrationDict(symptomRegistration: firebaseSymptomRegistration, userId: userId)
        
        if let documentId = firebaseSymptomRegistration.id {
            db.collection(registrationCollection).document(documentId).setData(registrationDict)
        } else {
            saveSymptomRegistration(symptomRegistrationDict: registrationDict)
        }
    }
    
    // Help function that saves a prepared symptom dict representing a symptom registration to db
    func saveSymptomRegistration(symptomRegistrationDict: [String: Any]) {
        // Add a new document with a generated id to collection.
        db.collection(registrationCollection).addDocument(data: symptomRegistrationDict)
    }
    
    // Help function used for mapping a FirebaseSymptomRegistration instance to a dictionary
    // that can be mapped to a Firebase document
    func prepareSymptomRegistrationDict(symptomRegistration: FirebaseSymptomRegistration, userId: String) -> [String: Any] {
        
        let intensityRegistrationList = symptomRegistration.intensityRegistrationList

        // implicit return because of onliner expression as return value
        let intensityRegistrationsForDB: [[String: Any]] = intensityRegistrationList.map({
            ["intensity": $0.intensity ?? NSNull(), "time_order": $0.timeOrder]
        })
        
        return ["date": symptomRegistration.date,
                "symptom_id": symptomRegistration.symptomId,
                "user_id": userId,
                "intensity_registration_list": intensityRegistrationsForDB]
    }
}
