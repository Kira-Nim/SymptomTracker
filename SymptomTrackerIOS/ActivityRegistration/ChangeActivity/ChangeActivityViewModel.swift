//
//  ChangeActivityViewModel.swift
//  SymptomTrackerIOS
//
//  Created by Kira Nim on 30/05/2022.
//

import Foundation
import UIKit

class ChangeActivityViewModel {
    
    private var view: ChangeActivityView?
    public var modelManager: ModelManager
    public var activity: Activity
    public var changeActivityCompletionCallback: (() -> Void)? = nil
    
    // MARK: Init
    init(modelManager: ModelManager, activity: Activity) {
        self.modelManager = modelManager
        self.activity = activity
    }
    
    // MARK: setView()
    public func setView(view: ChangeActivityView) {
        self.view = view
        view.nameInputField.delegate = self
        view.nameInputField.text = activity.name
    }
    
    // MARK: viewDidAppear()
    // Function for showing keyboard and pre selecting the text in the inputfield when view appears.
    public func viewDidAppear() {
        view?.nameInputField.becomeFirstResponder()
        view?.nameInputField.selectAll(nil)
    }
    
    // MARK: Other
    
    public func saveActivityName() {
        let newName = view?.nameInputField.text
        
        if let newName = newName {
            if newName.count > 55 {
                view?.errorMessage.isHidden = false
            } else {
                activity.name = newName
                modelManager.updateActivity(activity: activity)
                changeActivityCompletionCallback?()
            }
        }
    }
}

extension ChangeActivityViewModel: UITextFieldDelegate {
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
  
}