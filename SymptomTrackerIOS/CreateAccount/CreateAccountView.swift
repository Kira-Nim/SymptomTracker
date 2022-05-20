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
        let inputField =  createInputFieldWith(placeholderText: "Email")
        return inputField
    }()
    
    public lazy var passwordInputField: UITextField = {
        let inputField = createInputFieldWith(placeholderText: "Password")
        return inputField
    }()
    
    public lazy var passwordRepeatInputField: UITextField = {
        let inputField = createInputFieldWith(placeholderText: "Gentag Password")
        return inputField
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
    
    public lazy var createButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Opret", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = .appFont(ofSize: 17, weight: .regular)
        button.backgroundColor = .appColor(name: .buttonBlue)
        button.setBackgroundImage(UIColor.appColor(name: .buttonBlueClicked).image(), for: .highlighted)
        button.layer.cornerRadius = 3
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.appColor(name: .buttonBlueBorderColor).cgColor
        return button
    }()
    
    
    public lazy var errorMessage: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = UIColor.red
        label.text = ""
        label.font = .appFont(ofSize: 17, weight: .regular)
        label.textAlignment = NSTextAlignment.center
        return label
    }()
    
    //MARK: init
    init() {
        /*
         The frame of the super view to this view, is temperarily set to zero until this view is placed into the view hierarchy and this this super view gets its real freme bounds from the OS (when the controller ordered to show its view)
         */
        super.init(frame: CGRect.zero)
        backgroundColor = .appColor(name: .backgroundColor)
        self.setupSubViews()
        self.setupConstraints()
    }
    
    // Explained in CreateUserViewController.swift
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
    private func createInputFieldWith(placeholderText: String) -> UITextField {
        let inputField = UITextField()
        
        inputField.translatesAutoresizingMaskIntoConstraints = false
        inputField.textColor = .appColor(name: .textBlack)
        inputField.font = .appFont(ofSize: 17, weight: .regular)
        //inputField.font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.bold)
        inputField.layer.cornerRadius = 3
        inputField.layer.borderWidth = 1.5
        inputField.layer.borderColor = UIColor.appColor(name: .textFieldBorderColor).cgColor
        inputField.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: [NSAttributedString.Key.foregroundColor: UIColor.appColor(name: .placeholderTextColor)])
        inputField.backgroundColor = .appColor(name: .backgroundColor)
        inputField.layer.cornerRadius = 3
        inputField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 13, height: 1))
        inputField.leftViewMode = .always
        return inputField
    }
}
