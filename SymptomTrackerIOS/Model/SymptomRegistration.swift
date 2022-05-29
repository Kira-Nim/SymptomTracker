//
//  SymptomRegistration.swift
//  SymptomTrackerIOS
//
//  Created by Kira Nim on 05/05/2022.
//

import Foundation

protocol SymptomRegistration: AnyObject  {
    var date: Date { get set }
    var intensityRegistrationList: [IntensityRegistration] { get set }
    var intensityRegistrationAverage: Int { get }
    var symptom: Symptom? { get set }
}
