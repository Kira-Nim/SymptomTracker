//
//  IntensityRegistration.swift
//  SymptomTrackerIOS
//
//  Created by Kira Nim on 05/05/2022.
//

import Foundation

protocol IntensityRegistration: AnyObject  {
    var intensity: Int { get set }
    var timeOrder: Int { get set }
}
