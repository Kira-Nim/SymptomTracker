//
//  UITabbarController+OrientationHandling.swift
//  SymptomTrackerIOS
//
//  Created by Kira Nim on 01/06/2022.
//

import Foundation
import UIKit

//

extension UITabBarController {
    public override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if let selected = selectedViewController {
            return selected.supportedInterfaceOrientations
        }
        return super.supportedInterfaceOrientations
    }
    
    public override var shouldAutorotate: Bool {
        if let selected = selectedViewController {
            return selected.shouldAutorotate
        }
        return super.shouldAutorotate
    }
    
    public override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        if let selected = selectedViewController {
            return selected.preferredInterfaceOrientationForPresentation
        }
        return super.preferredInterfaceOrientationForPresentation
    }
}
