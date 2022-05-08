//
//  Activity.swift
//  SymptomTrackerIOS
//
//  Created by Kira Nim on 05/05/2022.
//

import Foundation
import Firebase

class FirebaseActivity: Activity {

    var date: Date
    var name: String
    var strain: Strain
    var numMinutes: Int
    
    // Initializer used when the user creates a new activity
    init() {
        self.date = Date()
        self.name = "Ny aktivitet"
        self.numMinutes = 0
        self.strain = .white
    }
    
    // Initializer used when mapping from activity from Firebase
    init(firebaseActivity: [String : Any]) {
        
        // Default values are a safety precaution - Thet should never be used
        self.date = (firebaseActivity["date"] as? Timestamp)?.dateValue() ?? Date()
        self.name = firebaseActivity["name"] as? String ?? ""
        self.numMinutes = firebaseActivity["num_minutes"] as? Int ?? 0
        
        if let strainInt = firebaseActivity["strain"] as? Int {
            let strain: Strain
            switch (strainInt) {
                case 0:
                    strain = Strain.red
                case 1:
                    strain = Strain.yellow
                case 2:
                    strain = Strain.green
                default:
                    strain = Strain.white
            }
            self.strain = strain
            
        }else {
            // Safety precaution - This should never be a problem - "else" should never be executed
            print("Strain parsing failed!")
            self.strain = Strain.white
        }
    }
}
