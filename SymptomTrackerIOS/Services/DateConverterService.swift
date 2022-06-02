//
//  DateConverterService.swift
//  SymptomTrackerIOS
//
//  Created by Kira Nim on 02/06/2022.
//

import Foundation
import UIKit

class DateConverterService {
    
    public func convertDateFrom(date: Date) -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "d MMM"
        
        let dateString = dateFormatterGet.string(from: date)
        
        return dateString
    }
}
