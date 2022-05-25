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
    public var modelManager: AccountModelManager
    public var afterCreationCallback: (()->Void)? = nil
    
    // MARK: Init
    init(modelManager: AccountModelManager) {
        self.modelManager = modelManager
    }

    // MARK: setView()
    public func setView(view: CreateAccountView) {
        self.view = view
        view.emailInputField.delegate = self
        view.passwordInputField.delegate = self
        view.passwordRepeatInputField.delegate = self
        
        view.createButton.addAction(UIAction {[weak self] _ in
            self?.createAccountOrShowError(email: view.emailInputField.text,
                                           password: view.passwordInputField.text,
                                           passwordRepeat: view.passwordRepeatInputField.text)
        }, for: .touchUpInside)
    }
    
    // MARK: Other functionality
    private func createAccountOrShowError(email: String?, password: String?, passwordRepeat: String?) {
        let validationService = ValidationService()
        let error = validationService.validateUserInputForAccountCreationOrReturnError(email: email, password: password, passwordRepeat: passwordRepeat)
        if let error = error {
            self.showErrorMessageFor(identifyer: error)
        } else {
            // Email and password can be forced unwrapped here because it has been validated that they are not nuill in createNewAccountWith
            self.modelManager.createNewAccountWith(email: email!, password: password!) { [weak self] (identifyer) in
                self?.showErrorMessageFor(identifyer: identifyer)
            }
        }
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
            view?.errorMessage.text = LocalizedStrings.shared.accountCreationFailedError
        }
    }
}






