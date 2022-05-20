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
    
    public lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        //label.textColor = UIColor(red: 107/255, green: 126/255, blue: 165/255, alpha: 1.0)
        label.textColor = .appColor(name: .textBlack)
        label.text = "Symptom Tracker"
        label.font = .appFont(ofSize: 30, weight: .medium)
        label.textAlignment = NSTextAlignment.center
        
        return label
    }()
    
    public lazy var brainImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "Logo"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    public lazy var imageContentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    public lazy var emailInputField: UITextField = {
        let inputField =  loginInputFieldWith(placeholderText: "Email")
        inputField.keyboardType = .emailAddress
        inputField.autocorrectionType = .no
        inputField.autocapitalizationType = .none
        return inputField
    }()
    
    public lazy var passwordInputField: UITextField = {
        let inputField = loginInputFieldWith(placeholderText: "Password")
        inputField.isSecureTextEntry = true
        return inputField
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
    
    public lazy var resetButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Nulstil Password", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = .appFont(ofSize: 20, weight: .medium)
        button.backgroundColor = .appColor(name: .buttonBlue)
        button.layer.cornerRadius = 3
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.appColor(name: .buttonBlueBorderColor).cgColor
        button.isHidden = true
        return button
    }()
    
    public lazy var loginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Log ind", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = .appFont(ofSize: 17, weight: .medium)
        button.backgroundColor = .appColor(name: .buttonBlue)
        button.layer.cornerRadius = 3
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.appColor(name: .buttonBlueBorderColor).cgColor
        
        return button
    }()
    
    public lazy var createAccountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
            label.textColor = .appColor(name: .textBlack)
        label.text = "Opret konto"
        label.font = .appFont(ofSize: 17, weight: .medium)
        label.textAlignment = NSTextAlignment.left
        return label
    }()
    
    public lazy var resetPasswordLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = .appColor(name: .textBlack)
        label.text = "Glemt password"
        label.font = .appFont(ofSize: 17, weight: .medium)
        label.textAlignment = NSTextAlignment.right
        return label
    }()
    
    public lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [createAccountLabel,
                                                       resetPasswordLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    public lazy var errorMessage: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = .appColor(name: .errorRed)
        label.text = ""
        label.font = .appFont(ofSize: 17, weight: .medium)
        label.textAlignment = .center
        return label
    }()
    
    public lazy var passwordResetConfirmationMessage: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
            label.textColor = .appColor(name: .confirmationGreen)
        label.text = "Der er sendt en email. Følg linket i mailen for at vælge et nyt password."
        label.font = .appFont(ofSize: 17, weight: .medium)
        label.textAlignment = .center
        label.isHidden = true
        return label
    }()
    
    public lazy var closeResetButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("✕", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.bold)
        button.setTitleColor(.appColor(name: .textBlack), for: .normal)
        button.isHidden = true
        return button
    }()
    
    //MARK: init
    init() {
        /*
         The frame of the super view to this view, is temperarily set to zero until this view is placed into the view hierarchy and this this super view gets its real freme bounds from the OS (when the controller ordered to show its view)
         */
        super.init(frame: CGRect.zero)
        backgroundColor = UIColor.white
        
        self.contentStackViewConstraint = contentStackView.heightAnchor.constraint(equalToConstant: 114)
        self.setupSubViews()
        self.setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
    private func loginInputFieldWith(placeholderText: String) -> UITextField {
        let inputField = UITextField()
        
        inputField.translatesAutoresizingMaskIntoConstraints = false
        inputField.textColor = UIColor.black
        inputField.font = .appFont(ofSize: 17, weight: .regular)
        inputField.layer.cornerRadius = 3
        inputField.layer.borderWidth = 1
        inputField.layer.borderColor = UIColor(red: 91/255, green: 107/255, blue: 142/255, alpha: 1.0).cgColor
        inputField.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 36/255, green: 57/255, blue: 99/255, alpha: 1.0)])
        
        inputField.backgroundColor = UIColor.white
        inputField.layer.cornerRadius = 3
        inputField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 13, height: 1))
        inputField.leftViewMode = .always
        
        return inputField
    }
}
