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

class AccountManager {
    
    var loggedInUserId: String
    
    init(){
        loggedInUserId = ""
    }
}
