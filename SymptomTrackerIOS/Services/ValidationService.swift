//
//  ValidationService.swift
//  SymptomTrackerIOS
//
//  Created by Kira Nim on 20/05/2022.
//

import Foundation

final class ValidationService {
    
    public func validateUserInputForAccountCreationOrReturnError(email: String?, password: String?, passwordRepeat: String?) -> AccountCreationResult? {
        // Check that the user has filled in all input fields
        guard let email = email, let password = password, let passwordRepeat = passwordRepeat else {
            return .emptyField
        }
        
        /* Check:
            1) that password repeat maches password,
            2) that email is formatted as an email should be,
            3) that the password is strong enough/secure enough
        */
        if validatePasswordRepeatFor(password: password, passwordRepeat: passwordRepeat) == false {
            return .repeatPasswordFailed
        }else if validateFormatOf(email: email) == false {
            return .invalidEmail
        }else if validatePasswordStrengthFor(password: password) == false {
            return .weakPasswordError
        }
        // If everything is allright
        return nil
    }
    
    public func validateLoginCredentialsOrReturnError(email: String?, password: String?) -> AccountLoginResult? {
        // Check that the user has filled in all input fields
        guard let email = email, let password = password else {
            return .emptyField
        }
        
        //Check that email is formatted as an email should be and that the password is strong enough/secure enough
        if validateFormatOf(email: email) == false {
            return .invalidEmail
        }
        // If everything is allright
        return nil
    }
    
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
