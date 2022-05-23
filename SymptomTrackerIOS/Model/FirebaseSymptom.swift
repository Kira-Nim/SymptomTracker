//
//  FirebaseSymptom.swift
//  SymptomTrackerIOS
//
//  Created by Kira Nim on 05/05/2022.
//

import Foundation

class FirebaseSymptom: Symptom {
    
    var symptomId: String?
    var name: String
    var disabled: Bool
    var visibilityOnGraph: Bool
    var sortingPlacement: Int
    var userId: String
    
    // Initializer used when the user creates a new symptom
    init(sortingPlacement: Int, userId: String) {
        self.name = ""
        self.disabled = false
        self.visibilityOnGraph = false
        self.sortingPlacement = sortingPlacement
        self.userId = userId
    }
    
    // Initializer used when mapping from Firebase to Symptom
    init(firebaseSymptom: [String: Any], symptomId: String) {
        self.symptomId = symptomId
        self.name = firebaseSymptom["name"] as? String ?? ""
        self.disabled = firebaseSymptom["disabled"] as? Bool ?? false
        self.visibilityOnGraph = firebaseSymptom["visibility_on_graph"] as? Bool ?? false
        self.sortingPlacement = firebaseSymptom["sorting_plaement"] as? Int ?? -1
        self.userId = firebaseSymptom["user_id"] as? String ?? ""
    }
}
