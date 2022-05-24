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

final class FlowCoordinator {
    
    private let viewModelProvider: ViewModelProvider
    private let window: UIWindow
    private var accountSettingsNavigationController: UINavigationController? = nil
    
    //MARK: Init
    init(viewModelProvider: ViewModelProvider, window: UIWindow) {
        self.viewModelProvider = viewModelProvider
        self.window = window
    }
    
    //MARK: Create controller hierarchy to be shown if user is logged in
    public func setRootViewController() {
        
        if(viewModelProvider.modelManager.isUserLoggedIn() == true) {
            let symptomRegistrationViewController = SymptomRegistrationViewController(viewModel: viewModelProvider.getSymptomRegistrationViewModel())
            let activityViewController = ActivityViewController(viewModel: viewModelProvider.getActivityViewModel())
            let insightViewController = InsightViewController(viewModel: viewModelProvider.getInsightViewModel())
            let accountViewModel = viewModelProvider.getAccountSettingsViewModel()
            accountViewModel.afterLogoutCallback = setRootViewController
            accountViewModel.symptomListSelectedCallback = createSymptomListViewController
            let accountSettingsViewController = AccountViewController(viewModel: accountViewModel)
            let symptomRegistrationNavigationController = UINavigationController(rootViewController: symptomRegistrationViewController)
            let activityNavigationController = UINavigationController(rootViewController: activityViewController)
            let insightNavigationController = UINavigationController(rootViewController: insightViewController)
            accountSettingsNavigationController = UINavigationController(rootViewController: accountSettingsViewController)
            
            if let accountSettingsNavigationController = accountSettingsNavigationController {
                
                let tabBarController = UITabBarController()
                tabBarController.viewControllers = [symptomRegistrationNavigationController,
                                                    activityNavigationController,
                                                    insightNavigationController,
                                                    accountSettingsNavigationController]
                
                window.rootViewController = tabBarController
            }
        } else {
            let loginViewModel = viewModelProvider.getLoginViewModel()
            let logInViewController = LoginViewController(viewModel: loginViewModel)
            window.rootViewController = logInViewController
            loginViewModel.afterLoginCallback = setRootViewController
            loginViewModel.presentCreateAccountCallback = { [unowned logInViewController] () in
                self.presentCreateAccountViewControllerTo(presenter: logInViewController)
            }
        }
    }
    
    func presentCreateAccountViewControllerTo(presenter: UIViewController) {
        let createAccountViewModel = viewModelProvider.getCreateAccountViewModel()
        createAccountViewModel.afterCreationCallback = setRootViewController
        let createAccountViewController = CreateAccountViewController(viewModel: createAccountViewModel)
        createAccountViewController.modalPresentationStyle = .automatic
        presenter.present(createAccountViewController, animated: true, completion: nil)
    }
    
    func createSymptomListViewController() {
        let symptomListViewModel = viewModelProvider.getSymptomListViewModel()
        symptomListViewModel.changeNameCallback = createChangeSymptomNameViewController
        let symptomListViewController = SymptomListViewController(viewModel: symptomListViewModel)
        accountSettingsNavigationController?.pushViewController(symptomListViewController, animated: true)
    }
    
    func createChangeSymptomNameViewController(symptom: Symptom) {
        let changeSymptomNameViewModel = viewModelProvider.getChangeSymptomNameViewModel(symptom: symptom)
        let changeSymptomNameViewController = ChangeSymptomNameViewController(viewModel: changeSymptomNameViewModel)
        
        changeSymptomNameViewModel.changeSymptomNameCompletionCallback = {
            self.accountSettingsNavigationController?.popViewController(animated: true)
        }
        
        accountSettingsNavigationController?.pushViewController(changeSymptomNameViewController, animated: true)
    }
}

