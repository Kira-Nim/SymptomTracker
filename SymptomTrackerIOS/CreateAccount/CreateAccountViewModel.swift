//
//  CreateAccountViewModel.swift
//  SymptomTrackerIOS
//
//  Created by Kira Nim on 12/05/2022.
//

import Foundation
import UIKit

final class CreateAccountViewModel: NSObject, UITextFieldDelegate {
    
    private var view: CreateAccountView? = nil
    public var modelManager: ModelManager
    public var afterCreationCallback: (()->Void)? = nil
    
    init(modelManager: ModelManager) {
        self.modelManager = modelManager
    }
    
    public func setView(view: CreateAccountView) {
        self.view = view
        
        view.emailInputField.delegate = self
        view.passwordInputField.delegate = self
        view.passwordRepeatInputField.delegate = self
        
        view.createButton.addAction(UIAction {[weak self] _ in
            if view.passwordInputField.text != view.passwordRepeatInputField.text {
                self?.showErrorMessageFor(identifyer: .repeatPasswordFailed)
            
            } else {
                if let email = view.emailInputField.text, let password = view.passwordInputField.text {
                    self?.modelManager.createNewAccountWith(email: email, password: password) { [weak self] (identifyer) in
                        self?.showErrorMessageFor(identifyer: identifyer)
                    }
                }
            }
        }, for: .touchUpInside)
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        switch (textField) {
            
            case view?.passwordInputField:
                view?.passwordRepeatInputField.becomeFirstResponder()
            
            case view?.emailInputField:
                view?.passwordInputField.becomeFirstResponder()
        
            default:
                textField.resignFirstResponder()
        }
        
        return true
    }
    
    private func showErrorMessageFor(identifyer: AccountCreationResult) {
        
        switch (identifyer) {
            case .repeatPasswordFailed:
                view?.errorMessage.text = "gentag password fejlede"
                
            case .emailAlreadyExist:
                view?.errorMessage.text = "Den valgte email eksisterer allerede"
            
            case .invalidEmail:
                view?.errorMessage.text = "Fejl med den valgte email"
                
            case .userCreated:
                view?.errorMessage.text = ""
                afterCreationCallback?()
            
            case .weakPasswordError:
                view?.errorMessage.text = "Password skal indeholde minimum 6 tegn"
                
            default:
                view?.errorMessage.text = "Fejl ved oprettelse af bruger"
        }
    }
}






