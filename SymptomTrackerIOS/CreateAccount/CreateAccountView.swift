//
//  CreateUserView.swift
//  SymptomTrackerIOS
//
//  Created by Kira Nim on 08/05/2022.
//

import Foundation
import UIKit
import SwiftUI

class CreateAccountView: UIView {
    
    // MARK: subviews
    public var brainImage = UIImageView(image: UIImage(named: "Logo"))
    public var emailInputField = UITextField()
    public var passwordInputField = UITextField()
    public var passwordRepeatInputField = UITextField()
    public var createButton = UIButton()
    public var errorMessage = UILabel()
    
    public lazy var imageContentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    public lazy var contentStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [emailInputField,
                                                       passwordInputField,
                                                       passwordRepeatInputField])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 10
        return stackView
    }()
    
    //MARK: init
    init() {
        /*
         The frame of the super view to this view, is temperarily set to zero until this view is placed into the view hierarchy and this this super view gets its real freme bounds from the OS (when the controller ordered to show its view)
         */
        super.init(frame: CGRect.zero)
        backgroundColor = .appColor(name: .backgroundColor)
        self.setAttributesOnSubview()
        self.setupSubViews()
        self.setupConstraints()
    }
    // Explained in CreateUserViewController.swift
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Set attributes on subviews
    func setAttributesOnSubview() {
        brainImage.translatesAutoresizingMaskIntoConstraints = false
        brainImage.contentMode = .scaleAspectFit
        
        setAttributesOnInputFieldWith(placeholderText: LocalizedStrings.shared.emailPlaceholderText, inputField: emailInputField)
        emailInputField.keyboardType = .emailAddress
        emailInputField.autocorrectionType = .no
        emailInputField.autocapitalizationType = .none
        
        setAttributesOnInputFieldWith(placeholderText: LocalizedStrings.shared.passwordPlaceholderText, inputField: passwordInputField)
        passwordInputField.isSecureTextEntry = true
        
        setAttributesOnInputFieldWith(placeholderText: LocalizedStrings.shared.passwordRepeatPlaceholderText, inputField: passwordRepeatInputField)
        passwordRepeatInputField.isSecureTextEntry = true
        
        createButton.translatesAutoresizingMaskIntoConstraints = false
        createButton.setTitle(LocalizedStrings.shared.createAccountButtonText, for: .normal)
        createButton.setTitleColor(UIColor.white, for: .normal)
        createButton.titleLabel?.font = .appFont(ofSize: 19, weight: .medium)
        createButton.backgroundColor = .appColor(name: .buttonColor)
        createButton.setBackgroundImage(UIColor.appColor(name: .buttonClicked).image(), for: .highlighted)
        createButton.layer.cornerRadius = 4
        createButton.layer.borderWidth = 0.5
        createButton.layer.borderColor = UIColor.appColor(name: .buttonBorderColor).cgColor
        
        errorMessage.translatesAutoresizingMaskIntoConstraints = false
        errorMessage.numberOfLines = 0
        errorMessage.textColor = .appColor(name: .errorRed)
        errorMessage.text = ""
        errorMessage.font = .appFont(ofSize: 18, weight: .medium)
        errorMessage.textAlignment = NSTextAlignment.center
    }
    
    // MARK: Setup SubViews
    func setupSubViews() {
        imageContentView.addSubview(brainImage)
        [imageContentView, contentStackView, createButton, errorMessage].forEach({self.addSubview($0)})
    }
    
    // MARK: Setup constraints
    func setupConstraints() {
        NSLayoutConstraint.activate([
            imageContentView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            imageContentView.bottomAnchor.constraint(equalTo: errorMessage.topAnchor, constant: -50),
            imageContentView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 33),
            imageContentView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -33),
            
            brainImage.centerYAnchor.constraint(equalTo: imageContentView.centerYAnchor, constant: 50),
            brainImage.centerXAnchor.constraint(equalTo: imageContentView.centerXAnchor),
            brainImage.heightAnchor.constraint(lessThanOrEqualToConstant: 135),
            
            errorMessage.bottomAnchor.constraint(equalTo: contentStackView.topAnchor, constant: -25),
            errorMessage.heightAnchor.constraint(equalToConstant: 48),
            errorMessage.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 33),
            errorMessage.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -33),
            
            contentStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 90),
            contentStackView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 33),
            contentStackView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -33),
            contentStackView.heightAnchor.constraint(equalToConstant: 161),
            
            createButton.heightAnchor.constraint(equalToConstant: 48),
            createButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 33),
            createButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -33),
            createButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -50),
        ])
    }
    
    //MARK: Help functions
    
    // Helpfunction for creating textField subclasses
    private func setAttributesOnInputFieldWith(placeholderText: String, inputField: UITextField) {
        inputField.translatesAutoresizingMaskIntoConstraints = false
        inputField.textColor = .appColor(name: .textBlack)
        inputField.font = .appFont(ofSize: 17, weight: .medium)
        inputField.layer.cornerRadius = 4
        inputField.layer.borderWidth = 0.5
        inputField.layer.borderColor = UIColor.appColor(name: .textFieldBorderColor).cgColor
        inputField.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: [NSAttributedString.Key.foregroundColor: UIColor.appColor(name: .placeholderTextColor)])
        inputField.backgroundColor = .appColor(name: .textFieldBackgroundColor)
        inputField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 13, height: 1))
        inputField.leftViewMode = .always
    }
}
