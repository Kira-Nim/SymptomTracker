//
//  AppDelegate.swift
//  SymptomTrackerIOS
//
//  Created by Kira Nim on 04/05/2022.
//

import UIKit
import Firebase

// This class has to do with model and business logic where SceneDelegate has to do with UI
@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var viewModelProvider: ViewModelProvider?
    var accountManager: AccountManager?
    
    
    // This function is run when the app is started
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        /* The GoogleServive-info.plist file will be read.
         It is now clear what project in firebase this app should be connected to and it is now possible to use the firebase library on the right data.
        */
        FirebaseApp.configure()
        
        /* Instantiated here (not above) because:
         These can not be instantieted before this point because:
         
         1) When instantiating ViewModelProvider you need a ModelManager instance and when instantiating the ModelManager, the model adapters are instantieted and the model adapters runs their listener methods on firebase collections.
         
         2) The accountManager runs its listener method on a firebase collection.
         
         Before 1 and 2 can happen the configuration file for Firebase (GoogleService-Info.plist) needs to be run.
         */
        viewModelProvider = ViewModelProvider(modelManager: ModelManager())
        accountManager = AccountManager()
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

