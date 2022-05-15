//
//  LoginViewModel.swift
//  SymptomTrackerIOS
//
//  Created by Kira Nim on 15/05/2022.
//

import Foundation

class LoginViewModel {
    
    private var view: LoginView? = nil
    public var modelManager: ModelManager
    
    init(modelManager: ModelManager) {
        self.modelManager = modelManager
    }
    
    public func setView(view: LoginView) {
        self.view = view
    }
}
