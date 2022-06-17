//
//  ModelManagerProtocol.swift
//  SymptomTrackerIOS
//
//  Created by Kira Nim on 12/05/2022.
//

import Foundation

// The state and functionality represented in this protocol represents a promise of what shall be consistent even if the backend and db is changed.
protocol ModelManager {
    var symptomsUpdatedNotificationName: NSNotification.Name { get }
    func isUserLoggedIn() -> Bool
    func getSymptoms() -> [Symptom]
    func updateSymptom(symptom: Symptom)
    func updateSymptoms(symptoms: [Symptom])
    func delete(symptom: Symptom)
    func createSymptom(sortingPlacement: Int) -> Symptom?
    func getRegistrationsForDate(date: Date, getRegistrationsForDateCompletionCallback: @escaping (([SymptomRegistration]) -> Void))
    func getRegistrationsForInterval(startDate: Date,
                                     endDate: Date,
                                     getRegistrationsForIntervalCompletionCallback: @escaping (([SymptomRegistration]) -> Void))
    func updateRegistration(symptomRegistration: SymptomRegistration)
    func getActivitiesForDate(date: Date, getActivitiesForDateCompletionCallback: @escaping (([Activity]) -> Void))
    func getActivitiesForInterval(startDate: Date,
                                  endDate: Date,
                                  getActivitiesForIntervalCompletionCallback: @escaping (([Activity]) -> Void))
    func update(activity: Activity)
    func update(activities: [Activity])
    func createActivity(date: Date) -> Activity?
    func delete(activity: Activity)
    
}
