//
//  ActivityAdapter.swift
//  SymptomTrackerIOS
//
//  Created by Kira Nim on 06/05/2022.
//

import Foundation
import Firebase
import SwiftUI

final class ActivityRepository {
    
    // variable containing collection name for symptom collection i firebase.
    let activityCollection = "activity"
    
    // Reference to database
    let db = Firestore.firestore()
    
    public func getActivities(date: Date, userId: String) -> [FirebaseActivity] {
        
        db.collection(activityCollection).whereField("user_id", isEqualTo: userId).whereField("date", isEqualTo: date).getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    var firebaseActivities: [FirebaseActivity] = []
                    for document in querySnapshot!.documents {
                        let documentId = document.documentID
                        let activityDocument = document.data()
                        let firebaseActivity = FirebaseActivity(firebaseActivityDocument: activityDocument, activityId: documentId)
                        firebaseActivities.append(firebaseActivity)
                    }
                    
                    // run callback passed from ModelManager.
                    // This callback will run callback passed from VM and thereby the view will be updated.
                    getSymptomRegistrationsForDateCompletionCallback(firebaseSymptomRegistrations)
                }
        }
    }
    
    
    public func updateActivities(activities: [FirebaseActivity], userId: String) {
        activities.forEach({
            updateActivity(firebaseActivity: $0, userId: userId)
        })
    }
    
    public func updateActivity(firebaseActivity: FirebaseActivity, userId: String) {
        let activityDict: [String: Any] = prepareActivityDict(firebaseActivity: firebaseActivity, userId: userId)
        if let documentId = firebaseActivity.id {
            db.collection(activityCollection).document(documentId).setData(activityDict)
        } else {
            saveActivity(activityDict: activityDict)
        }
    }
    
    private func saveActivity(activityDict: [String: Any]) {
        // Add a new document with a generated id to collection.
        db.collection(activityCollection).addDocument(data: activityDict)
    }
    
    public func delete(activity: FirebaseActivity) {
        if let documentId = activity.id {
            db.collection(activityCollection).document(documentId).delete() { err in
                if let err = err {
                    print("Error removing document: \(err)")
                } else {
                    print("Document successfully removed!")
                }
            }
        }
    }
    
    // Help function used for mapping a FirebaseSymptomRegistration instance to a dictionary
    // that can be mapped to a Firebase document
    func prepareActivityDict(firebaseActivity: FirebaseActivity, userId: String) -> [String: Any] {
        return ["date": firebaseActivity.date,
                "name": firebaseActivity.name,
                "user_id": firebaseActivity.userId,
                "strain": firebaseActivity.strain,
                "numMinutes": firebaseActivity.numMinutes]
    }
}
