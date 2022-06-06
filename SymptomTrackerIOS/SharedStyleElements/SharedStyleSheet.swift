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
        case switchButtonOnTintColor
        case sectionBacgroundColor
        case dateLabelColor
        case registrationButtonBorderColor
        case registrationButtonText
        case createBacgroundColor
        case shadowColor
        case tabbarColor
        case graphSegmentedControlColor
        case insightBackgroundColor
        case graphWhite
        case insightSegmentedControlBackgroundColor
        case calenderPickerButtonBorderColor
        
        case graphLineColor01
        case graphLineColor02
        case graphLineColor03
        case graphLineColor04
        case graphLineColor05
        case graphLineColor06
        case graphLineColor07
        case graphLineColor08
        case graphLineColor09
        case graphLineColor10
        case graphLineColor11
        case graphLineColor12
        case graphLineColor13
        case graphLineColor14
        case graphLineColor15
        case graphLineColor16
        case graphLineColor17
        case graphLineColor18
        case graphLineColor19
        case graphLineColor20
        case graphLineColor21
        case graphLineColor22
        case graphLineColor23
    }
    
    static func appColor(name: AppColor) -> UIColor {
        switch name {
            case .errorRed:
                return UIColor(red: 217/255, green: 91/255, blue: 30/255, alpha: 1.0) // Error red
            case .confirmationGreen:
                return UIColor(red: 161/255, green: 179/255, blue: 132/255, alpha: 1.0) // Confirmation green
            case .buttonColor:
                return UIColor(red: 208/255, green: 193/255, blue: 184/255, alpha: 1.0) // Grey/brown
            case .buttonBorderColor:
                return UIColor(red: 208/255, green: 193/255, blue: 184/255, alpha: 1.0) // Grey/brown
            case .buttonClicked:
                return UIColor(red: 200/255, green: 182/255, blue: 174/255, alpha: 1.0) // Grey/brown semi darker
            case .buttonTextColor:
                return UIColor.white // white
            case .textFieldBorderColor:
                return UIColor(red: 73/255, green: 69/255, blue: 70/255, alpha: 1.0) // "Text Black"
            case .textFieldBackgroundColor:
                return UIColor.white // white
            case .textFieldText:
                return UIColor(red: 73/255, green: 69/255, blue: 70/255, alpha: 1.0) // "Text Black"
            case .headerColor:
                return UIColor(red: 45/255, green: 45/255, blue: 45/255, alpha: 1.0) // "Header black"
            case .textBlack:
                return UIColor(red: 73/255, green: 69/255, blue: 70/255, alpha: 1.0) // "Text Black"
            case .placeholderTextColor:
                return UIColor(red: 125/255, green: 117/255, blue: 114/255, alpha: 1.0)
            case .backgroundColor:
                return UIColor.white // white
            case .createBacgroundColor:
                return UIColor(red: 242/255, green: 241/255, blue: 239/255, alpha: 1.0)
            case .registrationGreen:
                return UIColor(red: 161/255, green: 179/255, blue: 132/255, alpha: 1.0) // Conformaton green
            case .registrationYellow:
                return UIColor(red: 240/255, green: 178/255, blue: 11/255, alpha: 1.0)
            case .registrationOrange:
                return UIColor(red: 240/255, green: 131/255, blue: 11/255, alpha: 1.0)
            case .registrationRed:
                return UIColor(red: 217/255, green: 91/255, blue: 30/255, alpha: 1.0) // Error red
            case .registrationNeutral:
                return UIColor(red: 208/255, green: 193/255, blue: 184/255, alpha: 1.0) // Grey/brown
            case .registrationWhite:
                return UIColor.white // white
            case .registrationButtonText:
                return UIColor(red: 73/255, green: 69/255, blue: 70/255, alpha: 1.0) // "Text Black"
            case .registrationButtonBorderColor:
                return UIColor(red: 97/255, green: 85/255, blue: 82/255, alpha: 1.0) // very dark grey/brown
            case .activityRed:
                return UIColor(red: 224/255, green: 85/255, blue: 18/255, alpha: 1.0)
            case .activityYellow:
                return UIColor(red: 240/255, green: 178/255, blue: 11/255, alpha: 1.0)
            case .activityGreen:
                return UIColor(red: 127/255, green: 157/255, blue: 82/255, alpha: 1.0)
            case .activityWhite:
                return UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1.0)
            case .switchButtonOnTintColor:
                return UIColor(red: 208/255, green: 193/255, blue: 184/255, alpha: 1.0) // Grey/brown
            case .sectionBacgroundColor:
                return UIColor.white // white
            case .dateLabelColor:
                return UIColor.white // white
            case .tabbarColor:
                return UIColor.white // white
            case .shadowColor:
                return UIColor(red: 208/255, green: 193/255, blue: 184/255, alpha: 1.0) // Grey/brown
            case .graphSegmentedControlColor:
                return UIColor(red: 208/255, green: 193/255, blue: 184/255, alpha: 1.0) // Grey/brown
            case .insightBackgroundColor:
                return UIColor.white // white
            case .graphWhite:
                return UIColor.white // white
            case .insightSegmentedControlBackgroundColor:
                return UIColor.white // white
            case .calenderPickerButtonBorderColor:
                return UIColor(red: 171/255, green: 160/255, blue: 155/255, alpha: 1.0) // A little darker Grey/brown
            
            case .graphLineColor01:
                return UIColor(red: 255/255, green: 189/255, blue: 0/255, alpha: 1.0) // varm gul
            case .graphLineColor02:
                return UIColor(red: 134/255, green: 136/255, blue: 228/255, alpha: 1.0) // Lys blå-lilla
            case .graphLineColor03:
                return UIColor(red: 133/255, green: 173/255, blue: 20/255, alpha: 1.0) // lys Avokado
            case .graphLineColor04:
                return UIColor(red: 108/255, green: 0/255, blue: 121/255, alpha: 1.0) // Mørk lilla
            case .graphLineColor05:
                return UIColor(red: 232/255, green: 143/255, blue: 199/255, alpha: 1.0) // Orange
            case .graphLineColor06:
                return UIColor(red: 33/255, green: 131/255, blue: 128/255, alpha: 1.0) // tyrkis grøn
            case .graphLineColor07:
                return UIColor(red: 255/255, green: 189/255, blue: 0/255, alpha: 1.0) // Varm gul /Sol
            case .graphLineColor08:
                return UIColor(red: 255/255, green: 64/255, blue: 0/255, alpha: 1.0) // Magenta mørk
            case .graphLineColor09:
                return UIColor(red: 255/255, green: 64/255, blue: 0/255, alpha: 1.0) // Klar rød
            case .graphLineColor10:
                return UIColor(red: 255/255, green: 137/255, blue: 0/255, alpha: 1.0) // Lys varm orange
            case .graphLineColor11:
                return UIColor(red: 158/255, green: 0/255, blue: 89/255, alpha: 1.0) // Mørk Magenta
            case .graphLineColor12:
                return UIColor(red: 0/255, green: 160/255, blue: 227/255, alpha: 1.0) // Mellem lys blå
            case .graphLineColor13:
                return UIColor(red: 3/255, green: 4/255, blue: 94/255, alpha: 1.0) // Mørkeblå/ næsten sort
            case .graphLineColor14:
                return UIColor(red: 130/255, green: 82/255, blue: 23/255, alpha: 1.0) // Grønlig mellembrun
            case .graphLineColor15:
                return UIColor(red: 107/255, green: 5/255, blue: 4/255, alpha: 1.0) // Mørk rødbrun
            case .graphLineColor16:
                return UIColor(red: 216/255, green: 17/255, blue: 89/255, alpha: 1.0) // Mørke lille
            case .graphLineColor17:
                return UIColor(red: 172/255, green: 94/255, blue: 39/255, alpha: 1.0) // Penacotta/Camel
            case .graphLineColor18:
                return UIColor(red: 172/255, green: 94/255, blue: 39/255, alpha: 1.0) // Penacotta/Camel
            case .graphLineColor19:
                return UIColor(red: 26/255, green: 161/255, blue: 34/255, alpha: 1.0) // Mørk græsgrøn
            case .graphLineColor20:
                return UIColor(red: 114/255, green: 187/255, blue: 208/255, alpha: 1.0) // lyseblå
            case .graphLineColor21:
                return UIColor(red: 64/255, green: 221/255, blue: 200/255, alpha: 1.0) // Turkis
            case .graphLineColor22:
                return UIColor(red: 222/255, green: 203/255, blue: 39/255, alpha: 1.0) // Grønlig gul
            case .graphLineColor23:
                return UIColor(red: 186/255, green: 143/255, blue: 232/255, alpha: 1.0) // lilla
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

// the colors for tabbars and navbars once and for all
func setAppearanceProxies() {
    UIBarButtonItem.appearance().tintColor = UIColor.appColor(name: .textBlack)
    UITabBar.appearance().tintColor = UIColor.appColor(name: .buttonClicked)
}



