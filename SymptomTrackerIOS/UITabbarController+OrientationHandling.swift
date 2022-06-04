//
//  UITabbarController+OrientationHandling.swift
//  SymptomTrackerIOS
//
//  Created by Kira Nim on 01/06/2022.
//

import Foundation
import UIKit

// This is an extension on our tabbar controller (UITabBarController).
// This functionality makes sure that when OS acceses the below propertien on a (our one) tabbarController
// Then the child controller of that tabbar wil be contacted instead
// SelectedViewController is the child of the tabbar that is responsible for the view at a given time (selected tabbar navigationController so to speak)
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
