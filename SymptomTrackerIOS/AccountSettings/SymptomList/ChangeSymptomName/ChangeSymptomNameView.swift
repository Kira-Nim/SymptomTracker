//
//  ChangeSymptomNameView.swift
//  SymptomTrackerIOS
//
//  Created by Kira Nim on 24/05/2022.
//

import Foundation
import UIKit

class ChangeSymptomNameView: UIView {
    
    init() {
        super.init(frame: CGRect.zero)
        backgroundColor = UIColor.appColor(name: .backgroundColor)
        setupSubViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public lazy var symptomNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = UIColor.appColor(name: .textBlack)
        label.text = LocalizedStrings.shared.createSymptomLabelText
        label.font = .appFont(ofSize: 23, weight: .regular)
        label.textAlignment = NSTextAlignment.center
        return label
    }()
    
    public lazy var nameInputField: UITextField = {
        let inputField =  UITextField()
        inputField.translatesAutoresizingMaskIntoConstraints = false
        inputField.autocorrectionType = .no
        inputField.autocapitalizationType = .sentences
        inputField.textColor = .appColor(name: .textBlack)
        inputField.font = .appFont(ofSize: 17, weight: .regular)
        inputField.layer.cornerRadius = 3
        inputField.layer.borderWidth = 1.5
        inputField.layer.borderColor = UIColor.appColor(name: .textFieldBorderColor).cgColor
        inputField.backgroundColor = .appColor(name: .backgroundColor)
        inputField.layer.cornerRadius = 3
        inputField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 13, height: 1))
        inputField.leftViewMode = .always
        return inputField
    }()
    
    public lazy var errorMessage: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = .appColor(name: .errorRed)
        label.text = LocalizedStrings.shared.inputIsToLongError
        label.font = .appFont(ofSize: 17, weight: .regular)
        label.textAlignment = NSTextAlignment.center
        label.isHidden = true
        return label
    }()
    
    private func setupSubViews() {
        [symptomNameLabel, nameInputField, errorMessage].forEach({self.addSubview($0)})
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            nameInputField.topAnchor.constraint(equalTo: self.centerYAnchor, constant: -40),
            nameInputField.heightAnchor.constraint(equalToConstant: 48),
            nameInputField.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 33),
            nameInputField.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -33),
            
            symptomNameLabel.bottomAnchor.constraint(equalTo: nameInputField.topAnchor, constant: -15),
            symptomNameLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            symptomNameLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            symptomNameLabel.heightAnchor.constraint(equalToConstant: 60),
            
            errorMessage.bottomAnchor.constraint(equalTo: symptomNameLabel.topAnchor),
            errorMessage.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 33),
            errorMessage.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -33)
            
            
        ])
    }
}
