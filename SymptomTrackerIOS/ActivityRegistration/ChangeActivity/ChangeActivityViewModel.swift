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
    private let activityStrainService = ActivityStrainService()
    
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
        view.strainSegmentedControl.selectedSegmentIndex = activity.strain
        
        // update segmented control color
        segmentChanged()
        let durationSeconds = Double(activity.numMinutes) * 60.0
        view.durationPicker.countDownDuration = durationSeconds
    }
    
    // MARK: viewDidAppear()
    // Function for showing keyboard and pre selecting the text in the inputfield when view appears.
    public func viewDidAppear() {
        view?.nameInputField.becomeFirstResponder()
        view?.nameInputField.selectAll(nil)
    }
    
    // MARK: Other
    
    // Callback for presentation of segmented controll
    // when a strain option is selected when creating on editing activity site.
    @objc
    private func segmentChanged() {
        guard let strainSegmentedControl = view?.strainSegmentedControl else { return }
        let value = strainSegmentedControl.selectedSegmentIndex
        let color = activityStrainService.getActivityColorForStrain(value)
        strainSegmentedControl.selectedSegmentTintColor = color
    }
    
    public func saveActivity() {
        let newName = view?.nameInputField.text
        let durationInMinutes = (view?.durationPicker.countDownDuration ?? 0)/60
        if let strain = view?.strainSegmentedControl.selectedSegmentIndex, let newName = newName {
            if newName.count > 50 {
                view?.errorMessage.isHidden = false
            } else {
                activity.name = newName
                activity.strain = strain
                activity.numMinutes = Int(durationInMinutes)
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
