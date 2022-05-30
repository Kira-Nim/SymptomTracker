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
    var activityDurationString: String {
        var hours = numMinutes / 60
        var minutes = numMinutes % 60
        return "Varighed: \(hours):\(minutes)"
    }
    var strainColor: UIColor {
        switch strain {
        case 3:
            return UIColor.appColor(name: .activityRed)
        case 2:
            return UIColor.appColor(name: .activityYellow)
        case 1:
            return UIColor.appColor(name: .activityGreen)
        default:
            return UIColor.appColor(name: .activityClear)
        }
    }
    
    // Initializer used when the user creates a new activity
    init(userId: String) {
        self.date = Date()
        self.name = ""
        self.numMinutes = 0
        self.strain = 0
        self.userId = userId
    }
    
    // Initializer used when mapping from activity from Firebase
    init(firebaseActivity: [String : Any], activityId: String) {
        // Default values are a safety precaution - Thet should never be used
        self.date = (firebaseActivity["date"] as? Timestamp)?.dateValue() ?? Date()
        self.name = firebaseActivity["name"] as? String ?? ""
        self.numMinutes = firebaseActivity["num_minutes"] as? Int ?? 0
        self.strain = firebaseActivity["strain"] as? Int ?? 0
        self.userId = firebaseActivity["user_id"] as? String ?? ""
        self.id = activityId
    }
}
