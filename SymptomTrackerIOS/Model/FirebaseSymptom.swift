//
//  FirebaseSymptom.swift
//  SymptomTrackerIOS
//
//  Created by Kira Nim on 05/05/2022.
//

import Foundation

class FirebaseSymptom: Symptom {
    
    var name: String
    var disabled: Bool
    var visibilityOnGraph: Bool
    var sortingPlacement: Int
    
    // Initializer used when the user creates a new activity
    init(sortingPlacement: Int) {
        self.name = ""
        self.disabled = false
        self.visibilityOnGraph = false
        self.sortingPlacement = sortingPlacement
    }
    
    // Initializer used when mapping from activity from Firebase
    init(firebaseSymptom: [String: Any]) {
        
        self.name = firebaseSymptom["name"] as? String ?? ""
        self.disabled = firebaseSymptom["disabled"] as? Bool ?? false
        self.visibilityOnGraph = firebaseSymptom["visibility_on_graph"] as? Bool ?? false
        self.sortingPlacement = firebaseSymptom["sorting_plaement"] as? Int ?? -1
    }
}
