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
    private var accountSettingsNavigationController: PortraintLockedNavigationController?
    private var activityNavigationController: PortraintLockedNavigationController?
    
    //MARK: Init
    init(viewModelProvider: ViewModelProvider, window: UIWindow) {
        self.viewModelProvider = viewModelProvider
        self.window = window
    }
    
    // MARK: setRootViewController
    
    // Create controller hierarchy to be shown if user is logged in
    public func setRootViewController() {
        
        if viewModelProvider.modelManager.isUserLoggedIn() == true {
            let symptomRegistrationViewController = SymptomRegistrationViewController(viewModel: viewModelProvider.getSymptomRegistrationViewModel())
            
            let activityViewModel = viewModelProvider.getActivityViewModel()
            activityViewModel.showEditActivitySceneCallback = createChangeActivityViewController
            let activityViewController = ActivityViewController(viewModel: activityViewModel)
            
            let insightViewController = InsightViewController(viewModel: viewModelProvider.getInsightViewModel())
            
            let accountViewModel = viewModelProvider.getAccountSettingsViewModel()
            accountViewModel.afterLogoutCallback = setRootViewController
            accountViewModel.symptomListSelectedCallback = createSymptomListViewController
            let accountSettingsViewController = AccountViewController(viewModel: accountViewModel)
            
            let symptomRegistrationNavigationController = PortraintLockedNavigationController(rootViewController: symptomRegistrationViewController)
            activityNavigationController = PortraintLockedNavigationController(rootViewController: activityViewController)
            let insightNavigationController = UINavigationController(rootViewController: insightViewController)
            accountSettingsNavigationController = PortraintLockedNavigationController(rootViewController: accountSettingsViewController)
            
            if let accountSettingsNavigationController = accountSettingsNavigationController, let activityNavigationController = activityNavigationController {
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
    
    /*
    // callback ("createChangeActivityViewController") will be executed when the new activity button is clicked.
    // It takes care of navigation to create/edit activity page and sets a callback on the new VM that goes
    // with the controller that was pushed. The callback given is to be executed when the save butten is clicked.
    // This method takes a another callback as param that will be passed on and executed
    // when the save activity button in edit/create state is pressed.
    // This "createChangeActivityViewController" method is given as a callback to the activityViewModel where it is stored in an att.
    // This method creates another callback - "newActivityCompletionCallback" which is set as an att. on changeActivityViewModel.
    // The "createChangeActivityViewController" takes yet another callback as param - "activitySavedCallback".
    // This callback is to be executed inside the "newActivityCompletionCallback" when this happens in the activityViewModel.
    // The "activitySavedCallback" is defines and passed as a param inside the activityViewModel.
    //
    // UI wise --> "createChangeActivityViewController" is run when the "create new activity button" is pressed.
    //         --> "newActivityCompletionCallback" and "activitySavedCallback" is executed when the "Gem" button is pressed.
    */
    func createChangeActivityViewController(activity: Activity, activitySavedCallback: @escaping () -> Void) {
        let changeActivityViewModel = viewModelProvider.getChangeActivityViewModel(activity: activity)
        let changeActivityViewController = ChangeActivityViewController(viewModel: changeActivityViewModel)
        
        changeActivityViewModel.newActivityCompletionCallback = {
            self.activityNavigationController?.popViewController(animated:true)
            activitySavedCallback()
        }
        
        activityNavigationController?.pushViewController(changeActivityViewController, animated: true)
    }
}

