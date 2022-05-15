//
//  FlowCoordinator.swift
//  SymptomTrackerIOS
//
//  Created by Kira Nim on 06/05/2022.
//

import Foundation
import UIKit

/* Responsibilities:
 
    The flowCoordinator is responsible for navigation - The flowcoordinator is responsible for
    creating all controllers in the system.
 
    It is responsible for creating the initial View hierarchy and providing an root controller.
 
    When creating controllers the Flowcoordinator must provide a VM for each controller.
    To do this it needs to have acces to the ViewModelProvider.
    Controller will create their views and provide these to the given VM.
 */

class FlowCoordinator {
    
    private let viewModelProvider: ViewModelProvider
    private let window: UIWindow
    
    //MARK: Init
    init(viewModelProvider: ViewModelProvider, window: UIWindow) {
        self.viewModelProvider = viewModelProvider
        self.window = window
    }
    
    //MARK: Create controller hierarchy
    func setInitialViewController() {
        
        if let loggedInUser = viewModelProvider.modelManager.getLoggedInUser() {
            
            let registrationTableViewController = RegistrationTableViewController()
            
            let symptomNavigationController = UINavigationController(rootViewController: registrationTableViewController)
            let activityNavigationController = UINavigationController()
            let insightNavigationController = UINavigationController()
            let accountSettingsController = UIViewController()
            
            let tabBarController = UITabBarController()
            tabBarController.viewControllers = [symptomNavigationController, activityNavigationController, insightNavigationController, accountSettingsController]
            
            window.rootViewController = tabBarController
            
            // window.rootViewController =    ...Initial hierarchy controller here - NB! Remove rootcontroller below
            
        } else {
            window.rootViewController = LoginViewController(viewModel: viewModelProvider.getLoginViewModel())
        }
    }
    
    /*
    let createAccountViewController = CreateAccountViewController(viewModel: viewModelProvider.getCreateAccountViewModel())
    window?.rootViewController = createAccountViewController
     
     */
}
