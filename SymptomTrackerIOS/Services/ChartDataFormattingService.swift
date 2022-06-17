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
    
    // MARK: generateChartDataVTOs()

    /* Function for getting data ready to be shown in graph.
     
     Function for getting a dictionary consisting of key = symptom.orderPlacement and value = [LineChartDataSet]
     
     The list of LineChartDataSet's contains instances of ReplacementLineChartDataSet instances which has been saved as LineChartDataSet's.
     
     ReplacementLineChartDataSet's are wrappers around a label att. containing symptom.name and an att. containing a list - ChartDataVTOs.
     */
    public func generateChartDataVTOs(for symptomRegistrations: [SymptomRegistration]) -> [Int: LineChartDataSet] {
        
        // Get dictionary containing symptom.orderPlacement as key and all registrations on that symptoms in a list - [Registrations] as value.
        var symptomToRegistrationsDict = createSymptomToRegistrationsDict(from: symptomRegistrations)
        
        // Creates a new dictionary where all registrations have been removed if they have nil as averageIntensity
        symptomToRegistrationsDict = removeRegistrationsWithNoIntensities(for: symptomToRegistrationsDict)
        
        sortRegistrationsByDate(for: symptomToRegistrationsDict)
        
        // Convert the above list to a list of ChartVTOs
        let symptomToChartVTOsDict = convertRegistrationsToChartVTOs(for: symptomToRegistrationsDict)
        
        // Create a ReplacementLineChartDataSet containing a ChartVTOs
        let result = insertChartVTOsIntoLineChartDataSets(dict: symptomToChartVTOsDict)
        
        return result
    }
    
    //MARK: createSymptomToRegistrationsDict()
    
    // Construct a dictionary containing symptom.orderPlacement as key and all registrations on that symptoms in a list - [Registrations] as value.
    // We use the placement order int from symptom object as the key, to represent its symptom
    private func createSymptomToRegistrationsDict(from symptomRegistrations: [SymptomRegistration]) -> [Int: [SymptomRegistration]] {
        var symptomToRegistrationsDict: [Int: [SymptomRegistration]] = [:]
        
        for registration in symptomRegistrations {
            /*
             "continue" is used like return, but instead of breaking out of the method completely, it
               just stops this iteration of the for loop and starts the next interation in loop
            */
            guard let placement = registration.symptom?.sortingPlacement else { continue }
            var registrationsList = symptomToRegistrationsDict[placement] ?? []
            registrationsList.append(registration)
            symptomToRegistrationsDict[placement] = registrationsList
        }
        
        return symptomToRegistrationsDict
    }
    
    // MARK: removeRegistrationsWithNoIntensities
    // creates a new dictionary where all registrations have been removed if they have nil as average intensity
    private func removeRegistrationsWithNoIntensities(for symptomToRegistrationsDict: [Int: [SymptomRegistration]]) -> [Int: [SymptomRegistration]] {
        return symptomToRegistrationsDict.mapValues { registrationsList in
            registrationsList.filter { $0.intensityRegistrationAverage != nil }
        }
    }
    
    // MARK: sortRegistrationsByDate
    private func sortRegistrationsByDate(for symptomToRegistrationsDict: [Int: [SymptomRegistration]]) {
        for var registrationsList in symptomToRegistrationsDict.values {
            registrationsList.sort { $0.date < $1.date }
        }
    }
    
    // MARK: convertRegistrationsToChartVTOs()
    
    /*
       This method takes a couple of steps to first convert registrations to chartdataentries, then put these into a chartdataset
       These conversions are all happening by making a new dictionary that uses the same keys as the first one
       - symptomPlacement
    */
    private func convertRegistrationsToChartVTOs(for symptomToRegistrationsDict: [Int: [SymptomRegistration]]) -> [Int: [ChartDataEntry]] {
        // map from dictionary containing values being [SymptomRegistration]'s to dict of [ChartDataEntry]'s, symptom.orderPlacement still being key
        let symptomToChartDataEntryListDict: [Int: [ChartDataEntry]] = symptomToRegistrationsDict.mapValues { registrationsList in
            // map from [SymptomRegistration] to [ChartDataEntry]
            let chartEntriesList = registrationsList.map { registration -> ChartDataEntry in
                let normalizedDate = Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: registration.date) ?? registration.date
                
                let dateAsTimeInterval = normalizedDate.timeIntervalSince1970
                let intensityAverage = averageIntensityFor(registration: registration)
                let entry = ChartDataEntry(x: dateAsTimeInterval, y: intensityAverage, data: registration)
                return entry
            }
            return chartEntriesList
        }
        return symptomToChartDataEntryListDict
    }
    
    // MARK: daysBetweenDates()
    private func daysBetweenDates(fromDate: Date, toDate: Date) -> Int {
        let fromDateStart = Calendar.current.startOfDay(for: fromDate)
        let toDateStart = Calendar.current.startOfDay(for: toDate)
        let numberOfDays = Calendar.current.dateComponents([.day], from: fromDateStart, to: toDateStart)
        return numberOfDays.day ?? 0
    }
    
    // MARK: averageIntensityFor()
    
    // Similar to averageIntensity in SymptomRegistration, but this one doesn't do any rounding
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
    
    // MARK: insertChartVTOsIntoLineChartDataSets()
    
    /* Create data instances that will be used to plot the graph.
        Function creating a dictionary consisting of key = symptom.orderPlacement and value = [ReplacementLineChartDataSet]
        
        The method will return a dictionary containing LineChartDataSet's and not ReplacementLineChartDataset's.
        ReplacementLineChartDataset extends LineChartDataSet.
     
        ReplacementLineChartDataSet's are wrappers around a label att. containing symptom.name and an att. containing a list - ChartDataVTOs.
    */
    private func insertChartVTOsIntoLineChartDataSets(dict: [Int: [ChartDataEntry]]) -> [Int: LineChartDataSet] {
        return dict.mapValues { chartEntryVTOs in
            var label = ""
            if chartEntryVTOs.count > 0 {
                
                // All this to get the name if the symptom of the registrations.
                // [0] because it is not important what registration because they all have the same symptom.
                // we have ti cast it as a SymptomRegistration because in the ChartDataEntry it will be stored as any.
                if let registration = chartEntryVTOs[0].data as? SymptomRegistration, let name = registration.symptom?.name {
                    label = name
                }
            }
            // ReplacementLineChartDataSet is a wrapper around a chartEntryVTOs and a label containing symptom name
            return ReplacementLineChartDataSet(entries: chartEntryVTOs, label: label)
        }
    }
}

// MARK: extension: ChartDataFormattingService

// Pie Chart
extension ChartDataFormattingService {
    
    public func generatePieChartDataVTOs(activities: [Activity], startDate: Date, endDate: Date) -> PieChartDataSet {
        // Make a dictionary to keep track of the sum of minutes for each strain level
        var strainDictionary = [
            0: 0,
            1: 0,
            2: 0,
            3: 0
        ]
        // Run through all activities and record the sum of the strain levels into the dictionary
        for activity in activities {
            guard let currentMinutes = strainDictionary[activity.strain] else { continue }
            let newMinutes = currentMinutes + activity.numMinutes
            strainDictionary[activity.strain] = newMinutes
        }
        let strainNames = ["Ingen", "Lidt", "Mellem", "Svær"]
        var entryHours = 0.0
        var entries: [PieChartDataEntry] = [0, 1, 2, 3].map { strain in // strain is each of the 4 values in list
            let numMinutes = strainDictionary[strain] ?? 0
            let name = strainNames[strain]
            let numHours = Double(numMinutes)/60.0
            entryHours += numHours
            return PieChartDataEntry(value: numHours, label: name)
        }
        // add non-registered time as an entry - NB this functionality was left out.
        let addNonRegisteredEntry = false
        if addNonRegisteredEntry {
            let startOfStartDate = Calendar.current.startOfDay(for: startDate)
            let dayAfterEndDate = Calendar.current.date(byAdding: .day, value: 1, to: endDate) ?? endDate
            let startOfDayAfterEndDate = Calendar.current.startOfDay(for: dayAfterEndDate)
            
            let diffSeconds = startOfDayAfterEndDate.timeIntervalSince1970 - startOfStartDate.timeIntervalSince1970
            let diffHours = diffSeconds / (60 * 60)
            let unregisteredHours = diffHours - entryHours
            let entry = PieChartDataEntry(value: unregisteredHours, label: "")
            entries.append(entry)
        }
        return PieChartDataSet(entries: entries)
    }
}
