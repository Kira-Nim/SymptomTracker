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
}
