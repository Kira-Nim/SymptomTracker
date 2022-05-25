//
//  ChangeSymptomNameViewModel.swift
//  SymptomTrackerIOS
//
//  Created by Kira Nim on 24/05/2022.
//

import Foundation
import UIKit

class ChangeSymptomNameViewModel: NSObject, UITextFieldDelegate {
    private var view: ChangeSymptomNameView?
    public var modelManager: ModelManager
    public var symptom: Symptom
    public var changeSymptomNameCompletionCallback: (() -> Void)? = nil
    
    // MARK: Init
    init(modelManager: ModelManager, symptom: Symptom) {
        self.modelManager = modelManager
        self.symptom = symptom
    }
    
    // MARK: setView()
    public func setView(view: ChangeSymptomNameView) {
        self.view = view
        view.nameInputField.delegate = self
        view.nameInputField.text = symptom.name
    }
    
    // MARK: viewDidAppear()
    // Function for showing keyboard and pre selecting the text in the inputfield when view appears.
    public func viewDidAppear() {
        view?.nameInputField.becomeFirstResponder()
        view?.nameInputField.selectAll(nil)
    }
    
    // MARK: Other
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    public func saveSymptomName() {
        let newName = view?.nameInputField.text
        
        if let newName = newName {
            if newName.count > 55 {
                view?.errorMessage.isHidden = false
            } else {
                symptom.name = newName
                modelManager.updateSymptom(symptom: symptom)
                changeSymptomNameCompletionCallback?()
            }
        }
    }
}
