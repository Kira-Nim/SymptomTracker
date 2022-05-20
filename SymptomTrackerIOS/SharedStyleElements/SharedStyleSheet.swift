//
//  SharedStyleSheet.swift
//  SymptomTrackerIOS
//
//  Created by Kira Nim on 20/05/2022.
//

import Foundation
import UIKit

extension UIFont {
    enum AppFontWeight {
        case thin
        case medium
        case bold
        case regular
    }
    
    static func appFont(ofSize size: CGFloat, weight: AppFontWeight) -> UIFont {
        switch weight {
            case .thin:
                return UIFont(name: "PingFangHK-Thin", size: size)!
            case .medium:
                return UIFont(name: "PingFangHK-Medium", size: size)!
            case .bold:
                return UIFont(name: "PingFangHK-Semibold", size: size)!
            case .regular:
                return UIFont(name: "PingFangHK-Regular", size: size)!
            }
    }
}

extension UIColor {
    enum AppColor {
        case errorRed
        case buttonBlue
        case buttonBlueBorderColor
        case buttonBlueClicked
        case buttonBlueTextColor
        case textFieldBorderColor
        case confirmationGreen
        case headerColor
        case textBlack
        case registrationGreen
        case registrationYellow
        case registrationOrange
        case registrationRed
        case activityRed
        case activityYellow
        case activityGreen
        case backgroundColor
        case placeholderTextColor
    }
    
    static func appColor(name: AppColor) -> UIColor {
        switch name {
            case .errorRed:
                return UIColor(red: 232/255, green: 55/255, blue: 2/255, alpha: 1.0)
            case .buttonBlue:
                return UIColor(red: 122/255, green: 145/255, blue: 195/255, alpha: 1.0)
            case .buttonBlueBorderColor:
                return UIColor.blue
            case .buttonBlueClicked:
                return UIColor.orange
            case .buttonBlueTextColor:
                return UIColor.white
            case .textFieldBorderColor:
                return UIColor(red: 106/255, green: 126/255, blue: 168/255, alpha: 1.0)
            case .confirmationGreen:
                return UIColor(red: 75/255, green: 119/255, blue: 127/255, alpha: 1.0)
            case .headerColor:
                return UIColor(red: 45/255, green: 45/255, blue: 45/255, alpha: 1.0)
            case .textBlack:
                return UIColor(red: 45/255, green: 45/255, blue: 45/255, alpha: 1.0)
            case .registrationGreen:
                return UIColor.systemGreen
            case .registrationYellow:
                return UIColor.systemYellow
            case .registrationOrange:
                return UIColor.systemOrange
            case .registrationRed:
                return UIColor.systemRed
            case .activityRed:
                return UIColor.systemRed
            case .activityYellow:
                return UIColor.systemYellow
            case .activityGreen:
                return UIColor.systemGreen
            case .backgroundColor:
                return UIColor.white
            case .placeholderTextColor:
                return UIColor(red: 173/255, green: 196/255, blue: 237/255, alpha: 1.0)
        }
    }
    
    /* Syntax painfully explained here:
     "CGSize = CGSize(width: 1, height: 1" default value if a size is not given as para.
       This function returns a UIImage
       "UIGraphicsImageRenderer(size: size)" is a call to an initializer, when the initializer returns, ".image" will be called on the return value from the initializer call.
        ".image" will return an UIImage.
        ".images" takes a callback as param. This callback will configure the UIImage that ".image" returns.
       The callback given to ".image()" takes one param "rendererContext"
       The callback given to ".image()" runs "self.setFill()", "self" being UIColor
       "setFill" is a method on the UIColor class. It will put self into fill kinda like selecting a color for the fill operation in word - "image" being my "word dokument".
        "rendererContext" will run fill whitch will fill the image with the selected color aka self aka UIColor.
     */
    func image(_ size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { rendererContext in
            self.setFill()
            rendererContext.fill(CGRect(origin: .zero, size: size))
        }
    }
}