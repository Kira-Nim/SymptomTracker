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
    private let firebaseAuth = Auth.auth()
    
    public func createAccountWith (email: String, password: String, createUserCompletionCallback: @escaping (String?) -> Void) {
        firebaseAuth.createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print(error.localizedDescription)
                createUserCompletionCallback(error.localizedDescription)
                
            } else if let authResult = authResult {
                self.loggedInUserId = authResult.user.uid
                createUserCompletionCallback(nil)
            }
        }
    }
    
    public func loginWith (email: String, password: String, loginCompletionCallback: @escaping (String?) -> Void) {
        firebaseAuth.signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print(error.localizedDescription)
                loginCompletionCallback(error.localizedDescription)
                
            } else if let authResult = authResult {
                self.loggedInUserId = authResult.user.uid
                loginCompletionCallback(nil)
            }
        }
    }
    
    public func logOut(logOutCompletionCallback: (() -> Void)?) {
        do {
            try firebaseAuth.signOut()
            self.loggedInUserId = nil
            logOutCompletionCallback?()
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }
    }
    
    public func resetPassword(email: String) {
        firebaseAuth.sendPasswordReset(withEmail: email) { error in
            if let error = error {
                print(error.localizedDescription)
            } else { print("Reset email has been sent")}
        }
    }
}

