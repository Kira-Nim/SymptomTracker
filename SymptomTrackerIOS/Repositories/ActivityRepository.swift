//
//  ActivityAdapter.swift
//  SymptomTrackerIOS
//
//  Created by Kira Nim on 06/05/2022.
//

import Foundation
import Firebase

final class ActivityRepository {
    
    // variable containing collection name for symptom collection i firebase.
    let activityCollection = "activity"
    
    // Reference to database
    let db = Firestore.firestore()
    
    var firebaseSymptoms: [FirebaseActivity] = []
    
    
}
