//
//  ChartDataFormattingService.swift
//  SymptomTrackerIOS
//
//  Created by Kira Nim on 03/06/2022.
//

import Foundation
import UIKit
import Charts

class ChartDataFormattingService {
    public func generateChartDataVTOs(for symptomRegistrations: [SymptomRegistration]) -> [Int: LineChartDataSet] {
        // make a dict that maps from symptom to list of registrations, so we can spearate the registration lists
        // We use the placement order int from symptom object as the key, to represent its symptom
        var symptomToRegistrationsDict = createSymptomToRegistrationsDict(from: symptomRegistrations)
        symptomToRegistrationsDict = removeRegistrationsWithNoIntensities(for: symptomToRegistrationsDict)
        sortRegistrationsByDate(for: symptomToRegistrationsDict)
        let symptomToChartVTOsDict = convertRegistrationsToChartVTOs(for: symptomToRegistrationsDict)
        let result = insertChartVTOsIntoLineChartDataSets(dict: symptomToChartVTOsDict)
        return result
    }
    
    // make a dict that maps from symptom to list of registrations, so we can spearate the registration lists
    // We use the placement order int from symptom object as the key, to represent its symptom
    private func createSymptomToRegistrationsDict(from symptomRegistrations: [SymptomRegistration]) -> [Int: [SymptomRegistration]] {
        var symptomToRegistrationsDict: [Int: [SymptomRegistration]] = [:]
        
        for registration in symptomRegistrations {
            // continue is used like return, but instead of breaking out of the method completely, it
            // just stops this iteration of the for loop and starts the next interation in loop
            guard let placement = registration.symptom?.sortingPlacement else { continue }
            var registrationsList = symptomToRegistrationsDict[placement] ?? []
            registrationsList.append(registration)
            symptomToRegistrationsDict[placement] = registrationsList
        }
        
        return symptomToRegistrationsDict
    }
    
    // creates a new dictionary where all registrations have been removed if they have nil as average intensity
    private func removeRegistrationsWithNoIntensities(for symptomToRegistrationsDict: [Int: [SymptomRegistration]]) -> [Int: [SymptomRegistration]] {
        return symptomToRegistrationsDict.mapValues { registrationsList in
            registrationsList.filter { $0.intensityRegistrationAverage != nil }
        }
    }
    
    private func sortRegistrationsByDate(for symptomToRegistrationsDict: [Int: [SymptomRegistration]]) {
        for var registrationsList in symptomToRegistrationsDict.values {
            registrationsList.sort { $0.date < $1.date }
        }
    }
    
    // This method takes a couple of steps to first convert registrations to chartdataentries, then put these into a chartdataset
    // These conversions are all happening by making a new dictionary that uses the same keys as the first one, i.e. the symptom placement
    private func convertRegistrationsToChartVTOs(for symptomToRegistrationsDict: [Int: [SymptomRegistration]]) -> [Int: [ChartDataEntry]] {
        let symptomToChartDataEntryListDict: [Int: [ChartDataEntry]] = symptomToRegistrationsDict.mapValues { registrationsList in
            var startDate: Date? = nil
            let chartEntriesList = registrationsList.map { registration -> ChartDataEntry in
                if startDate == nil {
                    startDate = registration.date
                }
                let fromDate = startDate ?? registration.date
                let daysDiff = daysBetweenDates(fromDate: fromDate, toDate: registration.date)
            
                let intensityAverage = averageIntensityFor(registration: registration)
                print("x: " + String(daysDiff) + " y: " + String(intensityAverage))
                let entry = ChartDataEntry(x: Double(daysDiff), y: intensityAverage, data: registration)
                return entry
            }
            return chartEntriesList
        }
        return symptomToChartDataEntryListDict
    }
    
    private func daysBetweenDates(fromDate: Date, toDate: Date) -> Int {
        let fromDateStart = Calendar.current.startOfDay(for: fromDate)
        let toDateStart = Calendar.current.startOfDay(for: toDate)
        let numberOfDays = Calendar.current.dateComponents([.day], from: fromDateStart, to: toDateStart)
        return numberOfDays.day ?? 0
    }
    
    // similar to averageIntensity in SymptomRegistration, but this one doesn't do any rounding
    // it assumes that there are non-nil intensities in the list (because any registration without that will have been filtered out by now)
    private func averageIntensityFor(registration: SymptomRegistration) -> Double {
        // Filter out all intensityRegistrations that have a nil intensity. Get a list of intensities.
        let intensityListWithoutNilValues = registration.intensityRegistrationList.compactMap({
            $0.intensity
        })
        
        // Get sum of intensity
        var intensitySum: Double = 0
        intensityListWithoutNilValues.forEach({
            intensitySum += Double($0)
        })

        let intensityLevelDouble: Double = intensitySum / Double(intensityListWithoutNilValues.count)
        return intensityLevelDouble
    }
    
    private func insertChartVTOsIntoLineChartDataSets(dict: [Int: [ChartDataEntry]]) -> [Int: LineChartDataSet] {
        return dict.mapValues { chartEntryVTOs in
            var label = ""
            if chartEntryVTOs.count > 0 {
                if let registration = chartEntryVTOs[0].data as? SymptomRegistration, let name = registration.symptom?.name {
                    label = name
                }
            }
            return LineChartDataSet(entries: chartEntryVTOs, label: label)
        }
    }
}
