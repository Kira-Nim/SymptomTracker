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
            let validationService = ValidationService()
            let email: String? = view.emailInputField.text
            let password: String? = view.passwordInputField.text
            let passwordRepeat: String? = view.passwordRepeatInputField.text
            
            if let email = email, let password = password, let passwordRepeat = passwordRepeat {
                if(validationService.validatePasswordRepeatFor(password: password, passwordRepeat: passwordRepeat) != true) {
                    self?.showErrorMessageFor(identifyer: .repeatPasswordFailed)
                }else if(validationService.validateFormatOf(email: email) != true) {
                    self?.showErrorMessageFor(identifyer: .invalidEmail)
                }else if(validationService.validatePasswordStrengthFor(password: password) != true) {
                    self?.showErrorMessageFor(identifyer: .weakPasswordError)
                }else {
                    self?.modelManager.createNewAccountWith(email: email, password: password) { [weak self] (identifyer) in
                        self?.showErrorMessageFor(identifyer: identifyer)
                    }
                }
            }else {
                self?.showErrorMessageFor(identifyer: .emptyField)
            }
        }, for: .touchUpInside)
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    private func showErrorMessageFor(identifyer: AccountCreationResult) {
        
        switch (identifyer) {
            case .repeatPasswordFailed:
            view?.errorMessage.text = LocalizedStrings.shared.repeatPasswordError
                
            case .emailAlreadyExist:
            view?.errorMessage.text = LocalizedStrings.shared.emailAlreadyExistError
            
            case .invalidEmail:
            view?.errorMessage.text = LocalizedStrings.shared.invalidEmailError
                
            case .userCreated:
                view?.errorMessage.text = ""
                afterCreationCallback?()
            
            case .weakPasswordError:
            view?.errorMessage.text = LocalizedStrings.shared.weakPasswordError
            
            case .emptyField:
            view?.errorMessage.text = LocalizedStrings.shared.emptyFieldError
                
            default:
            view?.errorMessage.text = LocalizedError.shared.accountCreationFailedError
        }
    }
}






