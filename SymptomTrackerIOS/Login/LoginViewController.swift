//
//  LoginViewController.swift
//  SymptomTrackerIOS
//
//  Created by Kira Nim on 15/05/2022.
//

import Foundation
import UIKit

final class LoginViewController: UIViewController {
    private var loginViewModel: LoginViewModel
    private lazy var loginView = LoginView()
    
    // MARK: Init
    init(viewModel: LoginViewModel) {
        loginViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    /* Formel requirement for all ViewControllers to have this initializer.
       For notes go to CreateAccountViewController
     */
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: loadView
    override func loadView() {
        view = loginView
    }
    
    // MARK: viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        loginViewModel.setView(view: loginView)
    }
    
    //MARK: Other
    
    /* This function overrides the getter function on UIViewController that returns the
       property supportedInterfaceOrientations which is used by iOS to understand what
       screen orientations is allowed. Default is .all
       This is needed because the supportedInterfaceOrientations proporty is a get only
       proporty.
       This way iOS will not ask the super but this controller and it get .portrait returnes as answer
     */
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
}
