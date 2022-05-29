//
//  SymptomRegistration.swift
//  SymptomTrackerIOS
//
//  Created by Kira Nim on 05/05/2022.
//

import Foundation

protocol SymptomRegistration: AnyObject  {
    var id: String? {get }
    var date: Date { get set }
    var intensityRegistrations: [IntensityRegistration] { get set }
    var intensityRegistrationAverage: Int { get }
    var symptomId: String? { get set }
}
