//
//  ActivityStrainPresenter.swift
//  SymptomTrackerIOS
//
//  Created by Kira Nim on 30/05/2022.
//

import Foundation
import UIKit

class ActivityStrainPresenter {
    
    public func getActivityColorForStrain(_ strain: Int) -> UIColor {
        switch strain {
        case 3:
            return UIColor.appColor(name: .activityRed)
        case 2:
            return UIColor.appColor(name: .activityYellow)
        case 1:
            return UIColor.appColor(name: .activityGreen)
        default:
            return UIColor.appColor(name: .activityClear)
        }
    }
}
