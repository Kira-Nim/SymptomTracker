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

    func getSymptomRegistrationsForDate(date: Date, symptomId: String) -> [FirebaseSymptomRegistration] {
        var firebaseRegistrations: [FirebaseSymptomRegistration] = []
        db.collection(registrationCollection).whereField("symptomId", isEqualTo: symptomId).whereField("date", isEqualTo: date).getDocuments() { (querySnapshot, err) in
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
}
