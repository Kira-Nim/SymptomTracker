//
//  Activity.swift
//  SymptomTrackerIOS
//
//  Created by Kira Nim on 05/05/2022.
//

import Foundation

enum Strain { case red, yellow, green, white }

protocol Activity {
    
    var date: Date { get set }
    var name: String { get set }
    var strain: Strain { get set }
    var numMinutes: Int { get set }
}
