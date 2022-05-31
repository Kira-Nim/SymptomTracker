//
//  ChangeActivityViewModel.swift
//  SymptomTrackerIOS
//
//  Created by Kira Nim on 30/05/2022.
//

import Foundation
import UIKit

class ChangeActivityViewModel: NSObject {
    
    private var view: ChangeActivityView?
    public var modelManager: ModelManager
    public var activity: Activity
    public var newActivityCompletionCallback: (() -> Void)? = nil
    private final let strainSegmentedControlColors = [UIColor.appColor(name: .activityWhite),
                                                      UIColor.appColor(name: .activityGreen),
                                                      UIColor.appColor(name: .activityYellow),
                                                      UIColor.appColor(name: .activityRed)]
    
    // MARK: Init
    init(modelManager: ModelManager, activity: Activity) {
        self.modelManager = modelManager
        self.activity = activity
    }
    
    // MARK: setView()
    // This is run when the controller runc viewDidLoad()
    public func setView(view: ChangeActivityView) {
        self.view = view
        view.nameInputField.delegate = self
        view.nameInputField.text = activity.name
        view.strainSegmentedControl.addTarget(self, action: #selector(segmentChanged), for: .valueChanged)
    }
    
    // MARK: viewDidAppear()
    // Function for showing keyboard and pre selecting the text in the inputfield when view appears.
    public func viewDidAppear() {
        view?.nameInputField.becomeFirstResponder()
        view?.nameInputField.selectAll(nil)
    }
    
    // MARK: Other
    
    // Callback for when a strain option is selected when creating or editing activity
    @objc
    private func segmentChanged() {
        guard let strainSegmentedControl = view?.strainSegmentedControl else { return }
                
        let value = strainSegmentedControl.selectedSegmentIndex
        let color = strainSegmentedControlColors[value]
        strainSegmentedControl.selectedSegmentTintColor = color
    }
    
    public func saveActivity() {
        let newName = view?.nameInputField.text
        
        if let newName = newName {
            if newName.count > 50 {
                view?.errorMessage.isHidden = false
            } else {
                activity.name = newName
                modelManager.update(activity: activity)
                newActivityCompletionCallback?()
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
