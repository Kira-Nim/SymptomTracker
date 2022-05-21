//
//  ModelManagerProtocol.swift
//  SymptomTrackerIOS
//
//  Created by Kira Nim on 12/05/2022.
//

import Foundation

protocol ModelManager {
    func createNewAccountWith (email: String, password: String, showErrorMessageFor: @escaping (AccountCreationResult) -> Void)
    
    func loginWith(email: String, password: String, showErrorMessageFor: @escaping (AccountLoginResult) -> Void)
    
    func logOut(logOutCompletionCallback: (() -> Void)?) -> Void
    
    func resetPassword(email: String)
    
    func isUserLoggedIn() -> Bool
}
