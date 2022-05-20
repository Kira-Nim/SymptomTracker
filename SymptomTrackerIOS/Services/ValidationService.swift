//
//  ValidationService.swift
//  SymptomTrackerIOS
//
//  Created by Kira Nim on 20/05/2022.
//

import Foundation

final class ValidationService {
    
    public func validateFormatOf(email: String) -> Bool {
        let emailPattern = #"^\S+@\S+\.\S+$"#
        
        let result = email.range(
            of: emailPattern,
            options: .regularExpression
        )

        let isValid = (result != nil)
        return isValid
    }
    
    public func validatePasswordRepeatFor(password: String, passwordRepeat: String) -> Bool {
        let isRepeatedCorrectly: Bool = (password == passwordRepeat)
        return isRepeatedCorrectly
    }
    
    public func validatePasswordStrengthFor(password: String) -> Bool {
        let isStrongEnough = password.count > 5
        return isStrongEnough
    }
}
