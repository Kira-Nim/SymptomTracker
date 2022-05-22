//
//  SymptomAdapter.swift
//  SymptomTrackerIOS
//
//  Created by Kira Nim on 06/05/2022.
//

import Foundation
import Firebase

final class SymptomRepository {
    
    // variable containing collection name for symptom collection i firebase.
    let symptomCollection = "symptoms"
    
    // Reference to database
    let db = Firestore.firestore()
    
    func saveSymptomToDB(symptomDocument: [String: Any]){
        
        // Add a new document with a generated id to collection.
        db.collection(symptomCollection).addDocument(data: symptomDocument)
        
    }
}
