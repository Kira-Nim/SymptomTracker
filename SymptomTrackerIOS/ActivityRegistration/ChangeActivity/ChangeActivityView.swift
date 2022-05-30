//
//  ChangeActivityView.swift
//  SymptomTrackerIOS
//
//  Created by Kira Nim on 30/05/2022.
//

import Foundation
import UIKit

class ChangeActivityView: UIView {
    
    // MARK: Subviews
    public var activityNameLabel = UILabel()
    public var nameInputField = UITextField()
    public var strainPicker = UIPickerView()
    public var strainLabel = UILabel()
    public var durationNameLabel = UILabel()
    public var durationPicker = UIDatePicker()
    public var errorMessage = UILabel()
    
    // MARK: Init
    init() {
        super.init(frame: CGRect.zero)
        backgroundColor = UIColor.appColor(name: .backgroundColor)
        
        setAttributesOnSubViews()
        setupSubViews()
        setupConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Set attributes on subviews
    private func setAttributesOnSubViews() {
        activityNameLabel.translatesAutoresizingMaskIntoConstraints = false
        activityNameLabel.numberOfLines = 0
        activityNameLabel.textColor = UIColor.appColor(name: .textBlack)
        activityNameLabel.text = LocalizedStrings.shared.createActivityNameLabelText
        activityNameLabel.font = .appFont(ofSize: 23, weight: .regular)
        activityNameLabel.textAlignment = NSTextAlignment.center
        
        durationNameLabel.translatesAutoresizingMaskIntoConstraints = false
        durationNameLabel.numberOfLines = 0
        durationNameLabel.textColor = UIColor.appColor(name: .textBlack)
        durationNameLabel.text = LocalizedStrings.shared.createActivityDurationLabelText
        durationNameLabel.font = .appFont(ofSize: 23, weight: .regular)
        durationNameLabel.textAlignment = NSTextAlignment.center

        strainLabel.translatesAutoresizingMaskIntoConstraints = false
        strainLabel.numberOfLines = 0
        strainLabel.textColor = UIColor.appColor(name: .textBlack)
        strainLabel.text = LocalizedStrings.shared.createActivityStrainLabelText
        strainLabel.font = .appFont(ofSize: 23, weight: .regular)
        strainLabel.textAlignment = NSTextAlignment.center
        
        nameInputField.translatesAutoresizingMaskIntoConstraints = false
        nameInputField.autocorrectionType = .no
        nameInputField.autocapitalizationType = .sentences
        nameInputField.textColor = .appColor(name: .textBlack)
        nameInputField.font = .appFont(ofSize: 17, weight: .regular)
        nameInputField.layer.cornerRadius = 3
        nameInputField.layer.borderWidth = 1.5
        nameInputField.layer.borderColor = UIColor.appColor(name: .textFieldBorderColor).cgColor
        nameInputField.backgroundColor = .appColor(name: .backgroundColor)
        nameInputField.layer.cornerRadius = 3
        nameInputField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 13, height: 1))
        nameInputField.leftViewMode = .always

        durationPicker.datePickerMode = UIDatePicker.Mode.countDownTimer
        
        errorMessage.translatesAutoresizingMaskIntoConstraints = false
        errorMessage.numberOfLines = 0
        errorMessage.textColor = .appColor(name: .errorRed)
        errorMessage.text = LocalizedStrings.shared.inputIsToLongError
        errorMessage.font = .appFont(ofSize: 17, weight: .regular)
        errorMessage.textAlignment = NSTextAlignment.center
        errorMessage.isHidden = true
    }
    // MARK: Setup subviews
    private func setupSubViews() {
        [activityNameLabel, nameInputField, errorMessage].forEach({self.addSubview($0)})
    }
    
    // MARK: Setup constraints
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            nameInputField.topAnchor.constraint(equalTo: self.centerYAnchor, constant: -40),
            nameInputField.heightAnchor.constraint(equalToConstant: 48),
            nameInputField.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 33),
            nameInputField.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -33),
            
            activityNameLabel.bottomAnchor.constraint(equalTo: nameInputField.topAnchor, constant: -15),
            activityNameLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            activityNameLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            activityNameLabel.heightAnchor.constraint(equalToConstant: 60),
            
            errorMessage.bottomAnchor.constraint(equalTo: activityNameLabel.topAnchor),
            errorMessage.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 33),
            errorMessage.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -33)
        ])
    }
}
