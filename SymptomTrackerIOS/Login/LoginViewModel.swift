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
    public var presentCreateAccountCallback: (()->Void)? = nil
    
    init(modelManager: ModelManager) {
        self.modelManager = modelManager
    }
    
    public func setView(view: LoginView) {
        self.view = view
        
        // set functionality to be executed when login button is tapped
        self.view?.loginButton.addAction(UIAction {[weak self] _ in
            self?.view?.passwordResetConfirmationMessage.isHidden = true
            self?.view?.errorMessage.text = ""
            self?.view?.errorMessage.isHidden = false
            
            if let email = view.emailInputField.text, let password = view.emailInputField.text {
                self?.modelManager.loginWith(email: email, password: password) {[weak self] (identifyer) in
                    
                    self?.showErrorMessageFor(identifyer: identifyer)
                }
            }
        }, for: .touchUpInside)
        
        // Set gesture recognizer on "passwordResetLabel" sub view and action for when it is tapped.
        if let passwordResetLabel = self.view?.resetPasswordLabel {
            passwordResetLabel.isUserInteractionEnabled = true
            
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(resetPasswordClicked))
            passwordResetLabel.addGestureRecognizer(tapGestureRecognizer)
        }
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
    
    // Functionality to be executed when "passwordResetLabel" sub view is tapped.
   @IBAction func resetPasswordClicked(_ gesture: UIGestureRecognizer) {
       self.view?.resetButton.isHidden = false
       self.view?.closeResetButton.isHidden = false
       self.view?.passwordResetConfirmationMessage.isHidden = true
       self.view?.loginButton.isHidden = true
       self.view?.passwordInputField.isHidden = true
       self.view?.createAccountLabel.isHidden = true
       self.view?.resetPasswordLabel.isHidden = true
       self.view?.contentStackViewConstraint?.constant = 50
       self.view?.errorMessage.isHidden = true
       self.view?.resetButton.addAction(UIAction {[weak self] _ in
           if let email = self?.view?.emailInputField.text {
               if(email != "") {
                   self?.modelManager.resetPassword(email: email)
                   self?.view?.resetButton.isHidden = true
                   self?.view?.loginButton.isHidden = false
                   self?.view?.passwordInputField.isHidden = false
                   self?.view?.createAccountLabel.isHidden = false
                   self?.view?.resetPasswordLabel.isHidden = false
                   self?.view?.errorMessage.isHidden = true
                   self?.view?.contentStackViewConstraint?.constant = 114
                   self?.view?.passwordResetConfirmationMessage.isHidden = false
               }else{
                   self?.view?.errorMessage.text = "Angiv email"
                   self?.view?.passwordResetConfirmationMessage.isHidden = true
                   self?.view?.errorMessage.isHidden = false
               }
           }
       }, for: .touchUpInside)
       self.view?.closeResetButton.addAction(UIAction {[weak self] _ in
           self?.view?.resetButton.isHidden = true
           self?.view?.loginButton.isHidden = false
           self?.view?.passwordInputField.isHidden = false
           self?.view?.createAccountLabel.isHidden = false
           self?.view?.resetPasswordLabel.isHidden = false
           self?.view?.errorMessage.isHidden = true
           self?.view?.contentStackViewConstraint?.constant = 114
           self?.view?.passwordResetConfirmationMessage.isHidden = true
           self?.view?.closeResetButton.isHidden = true
       }, for: .touchUpInside)
   }
       
}
