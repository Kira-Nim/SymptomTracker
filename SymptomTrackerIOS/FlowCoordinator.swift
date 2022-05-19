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
    
    //MARK: Create controller hierarchy to be shown if user is logged in
    public func setRootViewController() {
        
        if let loggedInUser = viewModelProvider.modelManager.getLoggedInUser() {
            
            let symptomRegistrationViewController = SymptomRegistrationViewController(viewModel: viewModelProvider.getSymptomRegistrationViewModel())
            let activityViewController = ActivityViewController(viewModel: viewModelProvider.getActivityViewModel())
            let insightViewController = InsightViewController(viewModel: viewModelProvider.getInsightViewModel())
            
            let accountViewModel = viewModelProvider.getAccountSettingsViewModel()
            accountViewModel.afterLogoutCallback = setRootViewController
            let accountSettingsViewController = AccountViewController(viewModel: accountViewModel)
            
            let symptomNavigationController = UINavigationController(rootViewController: symptomRegistrationViewController)
            let activityNavigationController = UINavigationController(rootViewController: activityViewController)
            let insightNavigationController = UINavigationController(rootViewController: insightViewController)
            let accountSettingsNavigationController = UINavigationController(rootViewController: accountSettingsViewController)
            
            let tabBarController = UITabBarController()
            tabBarController.viewControllers = [symptomNavigationController, activityNavigationController, insightNavigationController, accountSettingsNavigationController]
            
            window.rootViewController = tabBarController
            
        } else {
            let loginViewModel = viewModelProvider.getLoginViewModel()
            let logInViewController = LoginViewController(viewModel: loginViewModel)
            window.rootViewController = logInViewController
            
            loginViewModel.afterLoginCallback = setRootViewController
            loginViewModel.presentCreateAccountCallback = { () in
                self.presentCreateAccountViewControllerTo(presenter: logInViewController)
            }
            
            /*
             let createAccountViewModel = viewModelProvider.getCreateAccountViewModel()
             createAccountViewModel.afterCreationCallback = setRootViewController
             window.rootViewController = CreateAccountViewController(viewModel: createAccountViewModel)
             */
        }
    }
    
    func presentCreateAccountViewControllerTo(presenter: UIViewController) {
        let createAccountViewModel = viewModelProvider.getCreateAccountViewModel()
        createAccountViewModel.afterCreationCallback = setRootViewController
        
        let createAccountViewController = CreateAccountViewController(viewModel: createAccountViewModel)
        presenter.present(createAccountViewController, animated: true, completion: nil)
    }
}
