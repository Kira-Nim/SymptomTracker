//
//  LoginViewController.swift
//  SymptomTrackerIOS
//
//  Created by Kira Nim on 15/05/2022.
//

import Foundation
import UIKit

class LoginViewController: UIViewController {
    
    private var loginViewModel: LoginViewModel
    
    init(viewModel: LoginViewModel) {
        loginViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
        let loginView = LoginView()
        view = loginView
        loginViewModel.setView(view: loginView)
    }
    
    /* Formel requirement for all ViewControllers to have this initializer.
       For notes go to CreateAccountViewController
     */
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
