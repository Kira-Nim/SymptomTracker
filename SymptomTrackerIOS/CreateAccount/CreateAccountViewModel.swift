//
//  CreateAccountViewModel.swift
//  SymptomTrackerIOS
//
//  Created by Kira Nim on 12/05/2022.
//

import Foundation
import UIKit


class CreateAccountViewModel {
    
    private var view: CreateAccountView? = nil
    public var modelManager: ModelManager
    public var afterCreationCallback: (()->Void)? = nil
    
    init(modelManager: ModelManager) {
        self.modelManager = modelManager
    }
    
    public func setView(view: CreateAccountView) {
        self.view = view
        
        view.createButton.addAction(UIAction {[weak self] _ in
            
            //self?.view?.createButton.backgroundColor = UIColor.blue
            
            if (!(view.passwordInputField.text == view.passwordRepeatInputField.text)) {
                self?.showErrorMessageFor(identifyer: .repeatPasswordFailed)
                
            } else {
                if let email = view.emailInputField.text, let password = view.emailInputField.text {
                    self?.modelManager.createNewAccountWith(email: email, password: password) { [weak self] (identifyer) in
                        self?.showErrorMessageFor(identifyer: identifyer)
                    }
                }
            }
        }, for: .touchUpInside)
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






