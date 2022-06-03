//
//  PortraitLockedNavigationController.swift
//  SymptomTrackerIOS
//
//  Created by Kira Nim on 01/06/2022.
//

import Foundation
import UIKit

class PortraintLockedNavigationController: UINavigationController {
    
    
    override var shouldAutorotate: Bool {
        return UIDevice.current.orientation == .portrait
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }

    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return UIInterfaceOrientation.portrait
    }

}
