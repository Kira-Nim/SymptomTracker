//
//  PortraitLockedNavigationController.swift
//  SymptomTrackerIOS
//
//  Created by Kira Nim on 01/06/2022.
//

import Foundation
import UIKit

// Because we want to be able to lock the device to only support portrait orientation when using the app
// apart from one page (Insight). We need to override som of the functionalyty available in UINavigationController.
class PortraintLockedNavigationController: UINavigationController {
    
    // Is called by OS when the phone has changed orientation.
    // Responsible for telling OS whether the screen should be turned if the phone is turned.
    // Default will return true (in the supers implementation)
    // "UIDevice.current.orientation" Is the position the phone has changed to, when this method is called by OS.
    override var shouldAutorotate: Bool {
        return UIDevice.current.orientation == .portrait
    }

    // This function is called IF the above function is called. This is a bit wierd but it works
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }

    // Same as above but when presenting a controller modaly (pop up from below)
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return UIInterfaceOrientation.portrait
    }

}
