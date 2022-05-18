//
//  LoginView.swift
//  SymptomTrackerIOS
//
//  Created by Kira Nim on 15/05/2022.
//

import Foundation
import UIKit

class LoginView: UIView {
    
    // MARK: Subviews
    
    public lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        //label.textColor = UIColor(red: 107/255, green: 126/255, blue: 165/255, alpha: 1.0)
        label.textColor = UIColor(red: 45/255, green: 45/255, blue: 45/255, alpha: 1.0)
        label.text = "Symptom Tracker"
        label.font = UIFont(name: "PingFangHK-Semibold", size: 30.0)
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
        return inputField
    }()
    
    public lazy var passwordInputField: UITextField = {
        let inputField = loginInputFieldWith(placeholderText: "Password")
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
    
    public lazy var loginButton: UIButton = {
        let button = UIButton()
        
        //button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.bold)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Log ind", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "PingFangHK-Medium", size: 20.0)
        button.backgroundColor = UIColor(red: 122/255, green: 145/255, blue: 195/255, alpha: 1.0)
        button.layer.cornerRadius = 3
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(red: 106/255, green: 126/255, blue: 168/255, alpha: 1.0).cgColor
        
        return button
    }()
    
    public lazy var createAccountButton: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = UIColor(red: 45/255, green: 45/255, blue: 45/255, alpha: 1.0)
        label.text = "Opret konto"
        label.font = UIFont(name: "PingFangHK-Medium", size: 17.0)
        label.textAlignment = NSTextAlignment.center
        return label
    }()
    
    public lazy var errorMessage: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = UIColor(red: 232/255, green: 55/255, blue: 2/255, alpha: 1.0)
        label.text = ""
        label.font = UIFont(name: "PingFangHK-Medium", size: 17.0)
        label.textAlignment = NSTextAlignment.center
        return label
    }()
    
    //MARK: init
    init() {
        /*
         The frame of the super view to this view, is temperarily set to zero until this view is placed into the view hierarchy and this this super view gets its real freme bounds from the OS (when the controller ordered to show its view)
         */
        super.init(frame: CGRect.zero)
        backgroundColor = UIColor.white
        
        self.setupSubViews()
        self.setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubViews() {
        imageContentView.addSubview(brainImage)
        [imageContentView, contentStackView, loginButton, createAccountButton, errorMessage, titleLabel].forEach({self.addSubview($0)})
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 60),
            titleLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 33),
            titleLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -33),
            titleLabel.heightAnchor.constraint(equalToConstant: 70),
            titleLabel.bottomAnchor.constraint(equalTo: imageContentView.topAnchor),
            
            imageContentView.bottomAnchor.constraint(equalTo: errorMessage.topAnchor, constant: -50),
            imageContentView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 33),
            imageContentView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -33),
            
            brainImage.centerYAnchor.constraint(equalTo: imageContentView.centerYAnchor),
            brainImage.centerXAnchor.constraint(equalTo: imageContentView.centerXAnchor),
            brainImage.heightAnchor.constraint(lessThanOrEqualToConstant: 135),
            
            errorMessage.bottomAnchor.constraint(equalTo: contentStackView.topAnchor, constant: -30),
            errorMessage.heightAnchor.constraint(equalToConstant: 48),
            errorMessage.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 33),
            errorMessage.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -33),
            
            contentStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 120),
            contentStackView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 33),
            contentStackView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -33),
            contentStackView.heightAnchor.constraint(equalToConstant: 114),
            
            createAccountButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 33),
            createAccountButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -33),
            createAccountButton.topAnchor.constraint(equalTo: contentStackView.bottomAnchor, constant: 5),
            createAccountButton.heightAnchor.constraint(equalToConstant: 48),
            
            loginButton.heightAnchor.constraint(equalToConstant: 48),
            loginButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 33),
            loginButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -33),
            loginButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -40),
        ])
    }
    
    //MARK: Help functions
    
    // Helpfunction for creating textField subclasses
    private func loginInputFieldWith(placeholderText: String) -> UITextField {
        let inputField = UITextField()
        
        inputField.translatesAutoresizingMaskIntoConstraints = false
        inputField.textColor = UIColor.black
        inputField.font = UIFont(name: "PingFangHK-Thin", size: 17.0)
        inputField.font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.bold)
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





