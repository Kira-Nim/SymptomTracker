//
//  LoginViewModel.swift
//  SymptomTrackerIOS
//
//  Created by Kira Nim on 15/05/2022.
//

import Foundation
import UIKit

class LoginViewModel {
    
    private var view: LoginView? = nil
    public var modelManager: ModelManager
    public var afterLoginCallback: (()->Void)? = nil
    
    init(modelManager: ModelManager) {
        self.modelManager = modelManager
    }
    
    public func setView(view: LoginView) {
        self.view = view
        
        self.view?.loginButton.addAction(UIAction {[weak self] _ in
            
            if let email = view.emailInputField.text, let password = view.emailInputField.text {
                
                self?.modelManager.loginWith(email: email, password: password) {[weak self] (identifyer) in
                    self?.showErrorMessageFor(identifyer: identifyer)
                }
                
            }
        }, for: .touchUpInside)
    }
    
    public func showErrorMessageFor(identifyer: AccountLoginResult) {
        
        switch (identifyer) {
        
            case .loginSucceded:
            view?.errorMessage.text = ""
            afterLoginCallback?()
            
            case .logInCredentialsNotValid:
            view?.errorMessage.text = "Forkert email eller password"
            
            case .accountDisabled:
            view?.errorMessage.text = "Kontoen er blevet lukket"
            
            default:
            view?.errorMessage.text = "Fejl ved login"
        }
    }
}
