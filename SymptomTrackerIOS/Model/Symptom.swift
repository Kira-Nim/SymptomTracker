//
//  Symptom.swift
//  SymptomTrackerIOS
//
//  Created by Kira Nim on 05/05/2022.
//

import Foundation

protocol Symptom {
    var name: String { get set }
    var disabled: Bool { get set }
    var visibilityOnGraph: Bool { get set }
    var sortingPlacement: Int { get set }
}
