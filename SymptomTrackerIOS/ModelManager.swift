//
//  ModelManagerProtocol.swift
//  SymptomTrackerIOS
//
//  Created by Kira Nim on 12/05/2022.
//

import Foundation

protocol ModelManager {
    func isUserLoggedIn() -> Bool
    func getSymptoms() -> [Symptom]
    func updateSymptom(symptom: Symptom)
    func updateSymptoms(symptoms: [Symptom])
    func delete(symptom: Symptom)
    func createSymptom(sortingPlacement: Int) -> Symptom?
    func getRegistrationsForDate(date: Date, getRegistrationsForDateCompletionCallback: @escaping (([SymptomRegistration]) -> Void))
    func updateRegistration(symptomRegistration: SymptomRegistration)
    
}
