//
//  AccountManager.swift
//  SymptomTrackerIOS
//
//  Created by Kira Nim on 06/05/2022.
//

import Foundation

/* Responsibilities of the AccountManager:
 
 The AccountManager is responsible for keeping track of who logged in user is.
 It is also responsible for adding this information to documents that is to be stored in Firebase.*/

import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

class AccountManager {
    public var loggedInUserId: String?
    
    public func createAccountWith (email: String, password: String, createUserCompletionCallback: @escaping (String?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
          
            if let error = error {
                createUserCompletionCallback(error.localizedDescription)
                
            } else if let authResult = authResult {
                self.loggedInUserId = authResult.user.uid
                createUserCompletionCallback(nil)
            }
        }
    }
}
