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
            
            if let email = view.emailInputField.text, let password = view.passwordInputField.text {
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
        
        // Set gesturerecognizer on "createAccountLabel" sub view and action for when it is tapped
        if let createAccountLabel = self.view?.createAccountLabel {
            createAccountLabel.isUserInteractionEnabled = true
            
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(presentCreateAccountClicked))
            createAccountLabel.addGestureRecognizer(tapGestureRecognizer)
        }
        
        // Set functionality for when the "resetButton" is clicked
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
        
        // Set functionality for when the x (or dismis reset mode) button is clicked
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
    
    // Helpfunction containing functionality for when the resetPasswordButton is clicked
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
    }
    
    // Help function for running presentCreateAccountCallback when gesturerecognizer for createAccountLabel is activated
    @IBAction func presentCreateAccountClicked(_gesture: UIGestureRecognizer) {
        if let presentCreateAccountCallback = presentCreateAccountCallback {
            presentCreateAccountCallback()
        }
    }
}



