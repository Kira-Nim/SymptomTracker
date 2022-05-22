//
//  ActivityView.swift
//  SymptomTrackerIOS
//
//  Created by Kira Nim on 15/05/2022.
//

import Foundation
import UIKit

class ActivityView: UIView {
    
    init() {
        super.init(frame: CGRect.zero)
        
        backgroundColor = UIColor.yellow
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
