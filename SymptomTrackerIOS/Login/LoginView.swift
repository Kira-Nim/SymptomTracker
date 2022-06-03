//
//  LoginView.swift
//  SymptomTrackerIOS
//
//  Created by Kira Nim on 15/05/2022.
//

import Foundation
import UIKit

class LoginView: UIView {
    public var contentStackViewConstraint: NSLayoutConstraint? = nil
    
    // MARK: Subviews
    
    public var titleLabel = UILabel()
    public var brainImage = UIImageView(image: UIImage(named: "Logo"))
    public var emailInputField = UITextField()
    public var passwordInputField = UITextField()
    public var resetButton = UIButton()
    public var loginButton = UIButton()
    public var createAccountLabel = UILabel()
    public var resetPasswordLabel = UILabel()
    public var errorMessage = UILabel()
    public var passwordResetConfirmationMessage = UILabel()
    public var closeResetButton = UIButton()
    
    public var imageContentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    public lazy var contentStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [emailInputField,
                                                       passwordInputField])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 10
        return stackView
    }()
    
    public lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [createAccountLabel,
                                                       resetPasswordLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    //MARK: init
    init() {
        /*
         The frame of the super view to this view, is temperarily set to zero until this view is placed into the view hierarchy and this this super view gets its real freme bounds from the OS (when the controller ordered to show its view)
         */
        super.init(frame: CGRect.zero)
        backgroundColor = UIColor.white
        
        self.setAttributesOnSubview()
        self.contentStackViewConstraint = contentStackView.heightAnchor.constraint(equalToConstant: 114)
        self.setupSubViews()
        self.setupConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setAttributesOnSubview() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.numberOfLines = 0
            //titleLabel.textColor = UIColor(red: 107/255, green: 126/255, blue: 165/255, alpha: 1.0)
        titleLabel.textColor = .appColor(name: .textBlack)
        titleLabel.text = LocalizedStrings.shared.appTitle
        titleLabel.font = .appFont(ofSize: 30, weight: .medium)
        titleLabel.textAlignment = NSTextAlignment.center
        
        brainImage.translatesAutoresizingMaskIntoConstraints = false
        brainImage.contentMode = .scaleAspectFit
        
        setAttributesOnTextFieldWith(placeholderText: LocalizedStrings.shared.emailPlaceholderText, inputField: emailInputField)
        emailInputField.keyboardType = .emailAddress
        emailInputField.autocorrectionType = .no
        emailInputField.autocapitalizationType = .none
        
        setAttributesOnTextFieldWith(placeholderText: LocalizedStrings.shared.passwordPlaceholderText, inputField: passwordInputField)
        passwordInputField.isSecureTextEntry = true
        
        resetButton.translatesAutoresizingMaskIntoConstraints = false
        resetButton.setTitle(LocalizedStrings.shared.resetPasswordButtonText, for: .normal)
        resetButton.setTitleColor(UIColor.appColor(name: .buttonTextColor), for: .normal)
        resetButton.titleLabel?.font = .appFont(ofSize: 17, weight: .medium)
        resetButton.backgroundColor = .appColor(name: .buttonColor)
        resetButton.setBackgroundImage(UIColor.appColor(name: .buttonClicked).image(), for: .highlighted)
        resetButton.layer.cornerRadius = 3
        resetButton.layer.borderWidth = 1
        resetButton.layer.borderColor = UIColor.appColor(name: .buttonBorderColor).cgColor
        resetButton.isHidden = true

        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.setTitle(LocalizedStrings.shared.loginButtonText, for: .normal)
        loginButton.setTitleColor(UIColor.appColor(name: .buttonTextColor), for: .normal)
        loginButton.titleLabel?.font = .appFont(ofSize: 19, weight: .medium)
        loginButton.backgroundColor = .appColor(name: .buttonColor)
        loginButton.setBackgroundImage(UIColor.appColor(name: .buttonClicked).image(), for: .highlighted)
        loginButton.layer.cornerRadius = 4
        loginButton.layer.borderWidth = 0.5
        loginButton.layer.borderColor = UIColor.appColor(name: .buttonBorderColor).cgColor
        
        createAccountLabel.translatesAutoresizingMaskIntoConstraints = false
        createAccountLabel.numberOfLines = 0
        createAccountLabel.textColor = .appColor(name: .placeholderTextColor)
        createAccountLabel.text = LocalizedStrings.shared.createAccountClickableLabelText
        createAccountLabel.font = .appFont(ofSize: 18, weight: .medium)
        createAccountLabel.textAlignment = NSTextAlignment.left
        
        resetPasswordLabel.translatesAutoresizingMaskIntoConstraints = false
        resetPasswordLabel.numberOfLines = 0
        resetPasswordLabel.textColor = .appColor(name: .placeholderTextColor)
        resetPasswordLabel.text = LocalizedStrings.shared.forgotPasswordClickableLabetText
        resetPasswordLabel.font = .appFont(ofSize: 18, weight: .medium)
        resetPasswordLabel.textAlignment = NSTextAlignment.right
        
        errorMessage.translatesAutoresizingMaskIntoConstraints = false
        errorMessage.numberOfLines = 0
        errorMessage.textColor = .appColor(name: .errorRed)
        errorMessage.text = ""
        errorMessage.font = .appFont(ofSize: 18, weight: .medium)
        errorMessage.textAlignment = .center
        
        passwordResetConfirmationMessage.translatesAutoresizingMaskIntoConstraints = false
        passwordResetConfirmationMessage.numberOfLines = 0
        passwordResetConfirmationMessage.textColor = .appColor(name: .confirmationGreen)
        passwordResetConfirmationMessage.text = LocalizedStrings.shared.passwordResetConfirmation
        passwordResetConfirmationMessage.font = .appFont(ofSize: 17, weight: .medium)
        passwordResetConfirmationMessage.textAlignment = .center
        passwordResetConfirmationMessage.isHidden = true
        
        closeResetButton.translatesAutoresizingMaskIntoConstraints = false
        closeResetButton.setTitle(LocalizedStrings.shared.x, for: .normal)
        closeResetButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.bold)
        closeResetButton.setTitleColor(.appColor(name: .textBlack), for: .normal)
        closeResetButton.isHidden = true

    }
    
    private func setupSubViews() {
        imageContentView.addSubview(brainImage)
        [imageContentView, contentStackView, loginButton, buttonStackView, errorMessage, titleLabel, resetButton, passwordResetConfirmationMessage, closeResetButton].forEach({self.addSubview($0)})
    }
    
    private func setupConstraints() {
        if let contentStackViewConstraint = contentStackViewConstraint {
            NSLayoutConstraint.activate([contentStackViewConstraint])
        }
        
        NSLayoutConstraint.activate([
            closeResetButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            closeResetButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            closeResetButton.heightAnchor.constraint(equalToConstant: 30),
            closeResetButton.widthAnchor.constraint(equalToConstant: 30),
            
            titleLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 35),
            titleLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 33),
            titleLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -33),
            titleLabel.heightAnchor.constraint(equalToConstant: 80),
            titleLabel.bottomAnchor.constraint(equalTo: imageContentView.topAnchor),
            
            imageContentView.bottomAnchor.constraint(equalTo: errorMessage.topAnchor, constant: -50),
            imageContentView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 33),
            imageContentView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -33),
            
            brainImage.centerYAnchor.constraint(equalTo: imageContentView.centerYAnchor),
            brainImage.centerXAnchor.constraint(equalTo: imageContentView.centerXAnchor),
            brainImage.heightAnchor.constraint(lessThanOrEqualToConstant: 135),
            
            errorMessage.bottomAnchor.constraint(equalTo: contentStackView.topAnchor, constant: -25),
            errorMessage.heightAnchor.constraint(equalToConstant: 48),
            errorMessage.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 33),
            errorMessage.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -33),
            
            passwordResetConfirmationMessage.bottomAnchor.constraint(equalTo: errorMessage.bottomAnchor),
            passwordResetConfirmationMessage.heightAnchor.constraint(equalTo: errorMessage.heightAnchor),
            passwordResetConfirmationMessage.leadingAnchor.constraint(equalTo: errorMessage.leadingAnchor),
            passwordResetConfirmationMessage.trailingAnchor.constraint(equalTo: errorMessage.trailingAnchor),
            
            contentStackView.topAnchor.constraint(equalTo: self.centerYAnchor, constant: 15),
            contentStackView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 33),
            contentStackView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -33),
            
            loginButton.heightAnchor.constraint(equalToConstant: 48),
            loginButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 33),
            loginButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -33),
            loginButton.topAnchor.constraint(greaterThanOrEqualTo: contentStackView.bottomAnchor, constant: 10),
            loginButton.bottomAnchor.constraint(equalTo: buttonStackView.topAnchor, constant: -52),
            
            resetButton.heightAnchor.constraint(equalTo: loginButton.heightAnchor),
            resetButton.leadingAnchor.constraint(equalTo: loginButton.leadingAnchor),
            resetButton.trailingAnchor.constraint(equalTo: loginButton.trailingAnchor),
            resetButton.bottomAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: -23),
            
            buttonStackView.leadingAnchor.constraint(equalTo: loginButton.leadingAnchor, constant: 4),
            buttonStackView.trailingAnchor.constraint(equalTo: loginButton.trailingAnchor, constant: -4),
            buttonStackView.topAnchor.constraint(equalTo: loginButton.bottomAnchor),
            buttonStackView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -25)
        ])
    }
    
    //MARK: Help functions
    
    // Helpfunction for creating textField subclasses
    private func setAttributesOnTextFieldWith(placeholderText: String, inputField: UITextField) {
        inputField.translatesAutoresizingMaskIntoConstraints = false
        inputField.textColor = UIColor.appColor(name: .textFieldText)
        inputField.font = .appFont(ofSize: 17, weight: .medium)
        inputField.layer.cornerRadius = 4
        inputField.layer.borderWidth = 0.5
        inputField.layer.borderColor = UIColor.appColor(name: .textFieldBorderColor) .cgColor
        inputField.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: [NSAttributedString.Key.foregroundColor: UIColor.appColor(name: .placeholderTextColor)])
        inputField.backgroundColor = UIColor.appColor(name: .textFieldBackgroundColor)
        inputField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 13, height: 1))
        inputField.leftViewMode = .always
    }
}
