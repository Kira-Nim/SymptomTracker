//
//  AccountModelManager.swift
//  SymptomTrackerIOS
//
//  Created by Kira Nim on 22/05/2022.
//

import Foundation

public enum AccountCreationResult {case repeatPasswordFailed,
                                        failed,
                                        emailAlreadyExist,
                                        userCreated,
                                        invalidEmail,
                                        weakPasswordError,
                                        emptyField }

public enum AccountLoginResult {case loginSucceded,
                                     logInCredentialsNotValid,
                                     failed,
                                     accountDisabled,
                                     emptyField,
                                     invalidEmail}

// The functionality represented in this protocol represents a promise of what shall be consistent even if the backend and db is changed.
protocol AccountModelManager {
    func createNewAccountWith (email: String, password: String, showErrorMessageFor: @escaping (AccountCreationResult) -> Void)
    
    func loginWith(email: String, password: String, showErrorMessageFor: @escaping (AccountLoginResult) -> Void)
    
    func logOut(logOutCompletionCallback: (() -> Void)?) -> Void
    
    func resetPassword(email: String)
}
