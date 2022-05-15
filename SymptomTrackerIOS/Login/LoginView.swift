//
//  LoginView.swift
//  SymptomTrackerIOS
//
//  Created by Kira Nim on 15/05/2022.
//

import Foundation
import UIKit

class LoginView: UIView {
    
    init() {
        /*
         The frame of the super view to this view, is temperarily set to zero until this view is placed into the view hierarchy and this this super view gets its real freme bounds from the OS (when the controller ordered to show its view)
         */
        super.init(frame: CGRect.zero)
        
        backgroundColor = UIColor.red
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
