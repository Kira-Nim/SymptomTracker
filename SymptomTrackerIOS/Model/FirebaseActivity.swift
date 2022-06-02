//
//  Activity.swift
//  SymptomTrackerIOS
//
//  Created by Kira Nim on 05/05/2022.
//

import Foundation
import Firebase
import UIKit

class FirebaseActivity: Activity {
    var id: String?
    var date: Date
    var name: String
    var strain: Int
    var numMinutes: Int
    var userId: String

    // Initializer used when the user creates a new activity
    init(userId: String, date: Date) {
        self.date = date
        self.name = ""
        self.numMinutes = 0
        self.strain = 0
        self.userId = userId
    }
    
    // Initializer used when mapping from activity from Firebase
    init(firebaseActivityDocument: [String : Any], activityId: String) {
        // Default values are a safety precaution - Thet should never be used
        self.date = (firebaseActivityDocument["date"] as? Timestamp)?.dateValue() ?? Date()
        self.name = firebaseActivityDocument["name"] as? String ?? ""
        self.numMinutes = firebaseActivityDocument["num_minutes"] as? Int ?? 0
        self.strain = firebaseActivityDocument["strain"] as? Int ?? 0
        self.userId = firebaseActivityDocument["user_id"] as? String ?? ""
        self.id = activityId
    }
}
