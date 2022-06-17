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
    
    // Becase every controller needs a VM provided by the FlowCoordinator when instantiated.
    // Is provided by the AppDelegate when the FlowCoordinator is instantiated. Holds the modelManager instance that will be used throughout the system.
    private let viewModelProvider: ViewModelProvider
    
    // Because we need to be anble to change the root ViewController of the window
    // Is provided by the SceneDelegate when the FlowCoordinator is instantiated.
    private let window: UIWindow
    
    // These needs to be accesible because we need to inject callbacks for navigation into some of the VM's
    private var accountSettingsNavigationController: PortraintLockedNavigationController?
    private var activityNavigationController: PortraintLockedNavigationController?
    private var insightNavigationController: UINavigationController?
    
    //MARK: Init
    init(viewModelProvider: ViewModelProvider, window: UIWindow) {
        self.viewModelProvider = viewModelProvider
        self.window = window
    }
    
    // MARK: setRootViewController()
    
    // Create controller hierarchy to be shown if user is logged in
    public func setRootViewController() {
        
        if viewModelProvider.modelManager.isUserLoggedIn() == true {
            let symptomRegistrationViewController = SymptomRegistrationViewController(viewModel: viewModelProvider.getSymptomRegistrationViewModel())
            
            // Create activityViewModel and set callback for switching to edit/create mode
            // Then create instance of activityViewController.
            let activityViewModel = viewModelProvider.getActivityViewModel()
            activityViewModel.showEditActivitySceneCallback = createChangeActivityViewController
            let activityViewController = ActivityViewController(viewModel: activityViewModel)
            
            // Create insightViewModel and set callback for navigating to symptom list for selection of symptoms to be shown on graph --> Push SymptomListViewController to navigation stack
            // Then create instance of insightViewController.
            let insightViewModel = viewModelProvider.getInsightViewModel()
            insightViewModel.presentSelectFromSymptomListController = presentSelectFromSymptomListController
            let insightViewController = InsightViewController(viewModel: insightViewModel)
            
            // Create instance of accountViewModel and set callback to executed when the user logs out. The callback is this method. When the user is looged out the above condition will evaluate to false and a nother root ViewController will be set.
            // Then create instance of accountSettingsViewController.
            let accountViewModel = viewModelProvider.getAccountSettingsViewModel()
            accountViewModel.afterLogoutCallback = setRootViewController
            accountViewModel.symptomListSelectedCallback = createSymptomListViewController
            let accountSettingsViewController = AccountViewController(viewModel: accountViewModel)
            
            // Create UINavigationControllers of type PortraintLockedNavigationController. This type is because we only want the insight page to be used in landscape orientation mode.
            // Exeption for insightNavigationController that will be of type UINavigationController.
            let symptomRegistrationNavigationController = PortraintLockedNavigationController(rootViewController: symptomRegistrationViewController)
            activityNavigationController = PortraintLockedNavigationController(rootViewController: activityViewController)
            accountSettingsNavigationController = PortraintLockedNavigationController(rootViewController: accountSettingsViewController)
            insightNavigationController = UINavigationController(rootViewController: insightViewController)
            
            // Now the creation of the view hierarchy has been made, the root view controller is set.
            if let accountSettingsNavigationController = accountSettingsNavigationController, let activityNavigationController = activityNavigationController, let insightNavigationController = insightNavigationController {
                let tabBarController = UITabBarController()
                tabBarController.viewControllers = [symptomRegistrationNavigationController,
                                                    activityNavigationController,
                                                    insightNavigationController,
                                                    accountSettingsNavigationController]
                window.rootViewController = tabBarController
            }
        } else {
            // Create instance of loginViewModel and logInViewController.
            let loginViewModel = viewModelProvider.getLoginViewModel()
            let logInViewController = LoginViewController(viewModel: loginViewModel)
            
            // set root controller to be loginViewController.
            window.rootViewController = logInViewController
            
            // Set callbacks to be used if the user wants to navigate to the create-account-page or the forgot-password-page.
            loginViewModel.afterLoginCallback = setRootViewController
            loginViewModel.presentCreateAccountCallback = { [unowned logInViewController] () in
                self.presentCreateAccountViewControllerTo(presenter: logInViewController)
            }
        }
    }
    
    // MARK: Callbacks for navigation
    
    // Callback for presenting the createAccount page. "modalPresentationStyle" is when it slides up from below.
    func presentCreateAccountViewControllerTo(presenter: UIViewController) {
        let createAccountViewModel = viewModelProvider.getCreateAccountViewModel()
        createAccountViewModel.afterCreationCallback = setRootViewController
        let createAccountViewController = CreateAccountViewController(viewModel: createAccountViewModel)
        createAccountViewController.modalPresentationStyle = .automatic
        presenter.present(createAccountViewController, animated: true, completion: nil)
    }
    
    // Callback for showing the symptomList incl. the option to go to edit/create mode.
    // This callback is used when navigation from the settings table page to the symptom list option.
    func createSymptomListViewController() {
        let symptomListViewModel = viewModelProvider.getSymptomListViewModel()
        symptomListViewModel.changeNameCallback = createChangeSymptomNameViewController
        let symptomListViewController = SymptomListViewController(viewModel: symptomListViewModel)
        accountSettingsNavigationController?.pushViewController(symptomListViewController, animated: true)
    }
    
    // Callback for showing the symptomlist excl the option to go to edit/create mode.
    // This callback is used when navigation from the insight page to the symptom list.
    func presentSelectFromSymptomListController() {
        let symptomListViewModel = viewModelProvider.getSymptomListViewModel()
        let symptomListViewController = SymptomListViewController(viewModel: symptomListViewModel, showEditNavbarItem: false)
        insightNavigationController?.pushViewController(symptomListViewController, animated: true)
    }
    
    // Callback for presenting the page where the symptom can be edited or created.
    // Used when navigation from the symptom list in edit mode page to the create new symptom or edit existing symptom page.
    func createChangeSymptomNameViewController(symptom: Symptom) {
        let changeSymptomNameViewModel = viewModelProvider.getChangeSymptomNameViewModel(symptom: symptom)
        let changeSymptomNameViewController = ChangeSymptomNameViewController(viewModel: changeSymptomNameViewModel)
        
        changeSymptomNameViewModel.changeSymptomNameCompletionCallback = {
            self.accountSettingsNavigationController?.popViewController(animated: true)
        }
        accountSettingsNavigationController?.pushViewController(changeSymptomNameViewController, animated: true)
    }
    
    /* Callback for when the new-activity-button is clicked.
       It takes care of navigation to create/edit activity page and sets a callback on the new VM that goes
       with the controller that was pushed. The callback given is to be executed when the save butten is clicked.
     */
    /*
       This method takes a another callback as param that will be passed on and executed
       when the save activity button in edit/create state is pressed.
       This "createChangeActivityViewController" method is given as a callback to the activityViewModel where it is stored in an att.
       This method creates another callback - "newActivityCompletionCallback" which is set as an att. on changeActivityViewModel.
       The "createChangeActivityViewController" takes yet another callback as param - "activitySavedCallback".
       This callback is to be executed inside the "newActivityCompletionCallback" when this happens in the activityViewModel.
       The "activitySavedCallback" is defines and passed as a param inside the activityViewModel.
      
       UI wise --> "createChangeActivityViewController" is run when the "create new activity button" is pressed.
               --> "newActivityCompletionCallback" and "activitySavedCallback" is executed when the "Gem" button is pressed.
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

