//
//  SymptomIntensityService.swift
//  SymptomTrackerIOS
//
//  Created by Kira Nim on 01/06/2022.
//

import Foundation
import UIKit

class SymptomIntensityService {
    
    public func getIntensityColorForRegistration(_ strain: Int?) -> UIColor {
        switch strain {
        case 4:
            return  UIColor.appColor(name: .registrationRed)
        case 3:
            return UIColor.appColor(name: .registrationOrange)
        case 2:
            return UIColor.appColor(name: .registrationYellow)
        case 1:
            return UIColor.appColor(name: .registrationGreen)
        case 0:
            return UIColor.appColor(name: .registrationNeutral)
        default:
            return UIColor.appColor(name: .registrationWhite)
        }
    }
}
