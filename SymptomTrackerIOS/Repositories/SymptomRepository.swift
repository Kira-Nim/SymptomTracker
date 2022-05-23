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
    
    var firebaseSymptoms: [FirebaseSymptom] = []
    
    // List of callbacks to be run when the Symptoms collection in db changes
    var callbacks: [() -> Void] = []
    
    // MARK: initializer
    init (){
        startListener()
    }
    
    // MARK: - startListener()
    func startListener() {
        // Set listener to get updates from Db when collection "Symptoms" changes.
        /*
         A snapShotListener contains a callback that is set on the Symptoms collection in db.
         */
        db.collection(symptomCollection).addSnapshotListener { snapshot, error in
            
            if let e = error {
                print("Error: \(e)")
                return
            }
            
            guard let docs = snapshot else {
                print("Failed to unwrap optional snapshot")
                return
            }
            
            // Because we dont want duplicates
            self.firebaseSymptoms.removeAll()
            
            // iterate through alle symptom documents in snapshot/collection
            // and create a firebaseSymptom for each document.
            for doc in docs.documents {
                // Create firebasesymptom
                let documentId = doc.documentID
                let symptomDocument = doc.data()
                let firebaseSymptom = FirebaseSymptom(firebaseSymptom: symptomDocument, symptomId: documentId)
                // Add firebaseSymptom to firebaseSymptoms list
                self.firebaseSymptoms.append(firebaseSymptom)
            }
            // run all callbacks in global variable called "callbacks"
            for callback in self.callbacks {
                callback()
            }
        }
    }
    
    func saveSymptomToDB(symptomDocument: [String: Any]){
        // Add a new document with a generated id to collection.
        db.collection(symptomCollection).addDocument(data: symptomDocument)
    }
    
    func getSymptomsFromDb() -> [FirebaseSymptom]{
        return firebaseSymptoms
    }
}
