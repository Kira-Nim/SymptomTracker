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

final class AccountManager {
    private let firebaseAuth = Auth.auth()
    public var loggedInUserId: String? {
        return firebaseAuth.currentUser?.uid
    }
    public var isLoggedIn: Bool {
        loggedInUserId != nil
    }
    
    public func createAccountWith (email: String, password: String, createUserCompletionCallback: @escaping (String?) -> Void) {
        firebaseAuth.createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print("________________________________________________________")
                print(error.localizedDescription)
                
                
                if let nsError: NSError = error as NSError? {
                    let errorCode = nsError.userInfo["FIRAuthErrorUserInfoNameKey"]
                    let errorCodeString: String? = errorCode as? String
                    createUserCompletionCallback(errorCodeString)
                                                     
                    print("....................................................")
                    for item in nsError.userInfo{
                        print(item)
                    }
                    print("****************************************************")
                    print(errorCode)
                    if ((errorCodeString) != nil) {print(errorCodeString ?? "No errorCodeString!")}
                    
                }
            } else if let authResult = authResult {
                createUserCompletionCallback(nil)
            }
        }
    }
    
    public func loginWith (email: String, password: String, loginCompletionCallback: @escaping (String?) -> Void) {
        firebaseAuth.signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print("________________________________________________________")
                print(error.localizedDescription)
                
                if let nsError: NSError = error as NSError? {
                    let errorCode = nsError.userInfo["FIRAuthErrorUserInfoNameKey"]
                    let errorCodeString: String? = errorCode as? String
                    loginCompletionCallback(errorCodeString)
                    
                    print("....................................................")
                    for item in nsError.userInfo{
                        print(item)
                    }
                    print("****************************************************")
                    print(errorCode)
                    if ((errorCodeString) != nil) {print(errorCodeString ?? "No errorCodeString!")}
                    
                }
                
            } else if let authResult = authResult {
                loginCompletionCallback(nil)
            }
        }
    }
    
    public func logOut(logOutCompletionCallback: (() -> Void)?) {
        do {
            try firebaseAuth.signOut()
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






