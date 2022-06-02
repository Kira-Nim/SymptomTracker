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
        case buttonColor
        case buttonBorderColor
        case buttonClicked
        case buttonTextColor
        case textFieldBorderColor
        case textFieldBackgroundColor
        case textFieldText
        case confirmationGreen
        case headerColor
        case textBlack
        case registrationGreen
        case registrationYellow
        case registrationOrange
        case registrationRed
        case registrationWhite
        case registrationNeutral
        case activityRed
        case activityYellow
        case activityGreen
        case activityWhite
        case backgroundColor
        case placeholderTextColor
        case switchButtonOffTintColor
        case switchButtonOnTintColor
        case switchButtonThumbColor
        case sectionBacgroundColor
        case dateLabelColor
        case registrationButtonBorderColor
        case registrationButtonText
        case createBacgroundColor
        case shadowColor
        case tabbarColor
    }
    
    static func appColor(name: AppColor) -> UIColor {
        switch name {
            case .errorRed:
                return UIColor(red: 217/255, green: 91/255, blue: 30/255, alpha: 1.0)
            
            case .confirmationGreen:
                return UIColor(red: 161/255, green: 179/255, blue: 132/255, alpha: 1.0)
            
            case .buttonColor:
                return UIColor(red: 208/255, green: 193/255, blue: 184/255, alpha: 1.0)
            
            case .buttonBorderColor:
                return UIColor(red: 208/255, green: 193/255, blue: 184/255, alpha: 1.0)
            
            case .buttonClicked:
                return UIColor(red: 200/255, green: 182/255, blue: 174/255, alpha: 1.0)
            
            case .buttonTextColor:
                return UIColor.white
            
            case .textFieldBorderColor:
                return UIColor(red: 73/255, green: 69/255, blue: 70/255, alpha: 1.0)

            case .textFieldBackgroundColor:
                return UIColor.white
            
            case .textFieldText:
                return UIColor(red: 73/255, green: 69/255, blue: 70/255, alpha: 1.0)
            
            case .headerColor:
                return UIColor(red: 45/255, green: 45/255, blue: 45/255, alpha: 1.0)
            
            case .textBlack:
                return UIColor(red: 73/255, green: 69/255, blue: 70/255, alpha: 1.0)
            
            case .placeholderTextColor:
                return UIColor(red: 125/255, green: 117/255, blue: 114/255, alpha: 1.0)
            
            case .backgroundColor:
                return UIColor.white
            
            case .createBacgroundColor:
                return UIColor(red: 245/255, green: 247/255, blue: 243/255, alpha: 1.0)
            
            case .registrationGreen:
                return UIColor(red: 161/255, green: 179/255, blue: 132/255, alpha: 1.0)
            
            case .registrationYellow:
                return UIColor(red: 240/255, green: 178/255, blue: 11/255, alpha: 1.0)
            
            case .registrationOrange:
                return UIColor(red: 240/255, green: 131/255, blue: 11/255, alpha: 1.0)
            
            case .registrationRed:
                return UIColor(red: 217/255, green: 91/255, blue: 30/255, alpha: 1.0)
            
            case .registrationNeutral:
                return UIColor(red: 129/255, green: 123/255, blue: 123/255, alpha: 1.0)
            
            case .registrationWhite:
                return UIColor.white
            
            case .registrationButtonBorderColor:
                return UIColor(red: 125/255, green: 117/255, blue: 114/255, alpha: 1.0)
            
            case .activityRed:
                return UIColor(red: 224/255, green: 85/255, blue: 18/255, alpha: 1.0)
            
            case .activityYellow:
                return UIColor(red: 240/255, green: 178/255, blue: 11/255, alpha: 1.0)
            
            case .activityGreen:
                //return UIColor(red: 161/255, green: 179/255, blue: 132/255, alpha: 1.0)
                return UIColor(red: 127/255, green: 157/255, blue: 82/255, alpha: 1.0)
            
            case .activityWhite:
                return UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1.0)

            case .switchButtonOffTintColor:
                //return UIColor(red: 239/255, green: 244/255, blue: 255/255, alpha: 1.0)
                return UIColor(red: 225/255, green: 225/255, blue: 225/255, alpha: 1.0)
            
            case .switchButtonOnTintColor:
                return UIColor(red: 131/255, green: 126/255, blue: 182/255, alpha: 1.0)
            
            case .switchButtonThumbColor:
                return UIColor.orange
            
            case .sectionBacgroundColor:
                return UIColor.white
                //return UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1.0)
            
            case .dateLabelColor:
                return UIColor.white
            
            case .registrationButtonText:
                return UIColor(red: 45/255, green: 45/255, blue: 45/255, alpha: 1.0)
            
            case .tabbarColor:
                return  UIColor.white
            
            case .shadowColor:
                return UIColor(red: 208/255, green: 193/255, blue: 184/255, alpha: 1.0)
        }
    }
    
    // Make an image containing a color to be used as background when applying color to view element
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

/*
 createActivityButtonView.layer.shadowColor = UIColor(red: 208/255, green: 193/255, blue: 184/255, alpha: 1.0).cgColor
 createActivityButtonView.layer.shadowOffset = CGSize(width: 0, height: 0)
 createActivityButtonView.layer.shadowRadius = 15
 createActivityButtonView.layer.shadowOpacity = 0.5
 
 // https://www.envato.com/blog/color-scheme-trends-in-mobile-app-design/
 */

/* Skal laves i scene delegate - før flowcoordinatoren laver controllers.
UITabBar.appearance().barTintColor = .yellow
UINavigationBar.appearance().barTintColor = UIColor.appColor(name: .activityYellow)
UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.blue]
UIBarButtonItem.appearance().tintColor = .magenta

//UITabBar.appearance().barTintColor = .yellow
*/
