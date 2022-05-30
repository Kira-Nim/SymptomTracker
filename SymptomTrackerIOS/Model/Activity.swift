//
//  Activity.swift
//  SymptomTrackerIOS
//
//  Created by Kira Nim on 05/05/2022.
//

import Foundation
import UIKit

protocol Activity: AnyObject {
    var date: Date { get set }
    var name: String { get set }
    var strain: Int { get set }
    var numMinutes: Int { get set }
}
