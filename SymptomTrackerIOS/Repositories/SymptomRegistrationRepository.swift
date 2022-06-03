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

    func getSymptomRegistrationsForDate(date: Date,
                                        userId: String,
                                        getSymptomRegistrationsForDateCompletionCallback: @escaping([FirebaseSymptomRegistration]) -> Void) {
        
        
        
        
        /* Because timestamp is incl. time we want to get all symptomRegistrations within the intaval of a day.
            If we where to use just one date, then this would, by firebase, be interpreted as one date with one time.
            The two dates below is used to create an query interval of exactly one day (after midnight - last second before next nidnight)
         */
        let startOfDay = Calendar.current.startOfDay(for: date)
        guard let startOfNextDay = Calendar.current.date(byAdding: .day, value: 1, to: startOfDay) else { return }
       
        db.collection(registrationCollection).whereField("user_id", isEqualTo: userId).whereField("date", isGreaterThanOrEqualTo: startOfDay).whereField("date", isLessThan: startOfNextDay).getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    var firebaseSymptomRegistrations: [FirebaseSymptomRegistration] = []
                    for document in querySnapshot!.documents {
                        let documentId = document.documentID
                        let symptomRegistrationDocument = document.data()
                        let firebaseSymptomRegistration = FirebaseSymptomRegistration(firebaseSymptomRegistration: symptomRegistrationDocument, symptomRegistrationId: documentId)
                        firebaseSymptomRegistrations.append(firebaseSymptomRegistration)
                    }
                    
                    // run callback passed from ModelManager.
                    // This callback will run callback passed from VM and thereby the view will be updated.
                    getSymptomRegistrationsForDateCompletionCallback(firebaseSymptomRegistrations)
                }
        }
    }
    
    func getSymptomRegistrationsForInterval(startDate: Date,
                                            endDate: Date,
                                            userId: String,
                                            getSymptomRegistrationsForIntervalCompletionCallback: @escaping([FirebaseSymptomRegistration]) -> Void) {
        let startOfStartDay = Calendar.current.startOfDay(for: startDate)
        let startOfEndDay = Calendar.current.startOfDay(for: endDate)
        guard let startOfDayAfterEndDay = Calendar.current.date(byAdding: .day, value: 1, to: startOfEndDay) else { return }
       
        db.collection(registrationCollection).whereField("user_id", isEqualTo: userId).whereField("date", isGreaterThanOrEqualTo: startOfStartDay).whereField("date", isLessThan: startOfDayAfterEndDay).getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    var firebaseSymptomRegistrations: [FirebaseSymptomRegistration] = []
                    for document in querySnapshot!.documents {
                        let documentId = document.documentID
                        let symptomRegistrationDocument = document.data()
                        let firebaseSymptomRegistration = FirebaseSymptomRegistration(firebaseSymptomRegistration: symptomRegistrationDocument, symptomRegistrationId: documentId)
                        firebaseSymptomRegistrations.append(firebaseSymptomRegistration)
                    }
                    
                    // run callback passed from ModelManager.
                    // This callback will run callback passed from VM and thereby the view will be updated.
                    getSymptomRegistrationsForIntervalCompletionCallback(firebaseSymptomRegistrations)
                }
        }
    }
    
    // Functopn for updating or saving symptom registration to db
    func updateSymptomRegistration(firebaseSymptomRegistration: FirebaseSymptomRegistration, userId: String) {
        
        let registrationDict: [String: Any] = prepareSymptomRegistrationDict(symptomRegistration: firebaseSymptomRegistration, userId: userId)
        
        if let documentId = firebaseSymptomRegistration.id {
            db.collection(registrationCollection).document(documentId).setData(registrationDict)
        } else {
            let documentId = saveSymptomRegistration(symptomRegistrationDict: registrationDict)
            firebaseSymptomRegistration.id = documentId
        }
    }
    
    // Help function that saves a prepared symptom dict representing a symptom registration to db
    func saveSymptomRegistration(symptomRegistrationDict: [String: Any]) -> String {
        // Add a new document with a generated id to collection.
        let documentReference = db.collection(registrationCollection).addDocument(data: symptomRegistrationDict)
        return documentReference.documentID
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
