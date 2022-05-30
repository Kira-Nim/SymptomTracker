//
//  Activity.swift
//  SymptomTrackerIOS
//
//  Created by Kira Nim on 05/05/2022.
//

import Foundation
import Firebase

class FirebaseActivity: Activity {
    var id: String
    var date: Date
    var name: String
    var strain: Int
    var numMinutes: Int
    var userId: String
    
    // Initializer used when the user creates a new activity
    init(userId: String) {
        self.date = Date()
        self.name = ""
        self.numMinutes = 0
        self.strain = 0
        self.userId = userId
    }
    
    // Initializer used when mapping from activity from Firebase
    init(firebaseActivity: [String : Any]) {
        // Default values are a safety precaution - Thet should never be used
        self.date = (firebaseActivity["date"] as? Timestamp)?.dateValue() ?? Date()
        self.name = firebaseActivity["name"] as? String ?? ""
        self.numMinutes = firebaseActivity["num_minutes"] as? Int ?? 0
        self.strain = firebaseActivity["strain"] as? Int ?? 0
    }
}
