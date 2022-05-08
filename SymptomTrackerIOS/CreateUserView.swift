//
//  CreateUserView.swift
//  SymptomTrackerIOS
//
//  Created by Kira Nim on 08/05/2022.
//

import Foundation
import UIKit

class CreateUserView: UIView {
    
    // MARK: Configuration of main View
    sebackgroundColor = UIColor.white
    
    // MARK: subviews
    private lazy var brainImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "Logo"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var emailInputField: UITextField = {
        let inputField = UITextField()
        inputField.translatesAutoresizingMaskIntoConstraints = false
        inputField.textColor = UIColor.black
        inputField.font = UIFont(name: "MarkerFelt-Thin", size: 20)
        inputField.placeholder = "Email"
        inputField.backgroundColor = UIColor.lightGray
        inputField.layer.cornerRadius = 3
        return inputField
    }()
    
    private lazy var passwordInputField: UITextField = {
        let inputField = UITextField()
        inputField.translatesAutoresizingMaskIntoConstraints = false
        inputField.textColor = UIColor.black
        inputField.font = UIFont(name: "MarkerFelt-Thin", size: 20)
        inputField.placeholder = "Password"
        inputField.backgroundColor = UIColor.lightGray
        inputField.layer.cornerRadius = 3
        return inputField
    }()
    
    private lazy var passwordRepeatInputField: UITextField = {
        let inputField = UITextField()
        inputField.translatesAutoresizingMaskIntoConstraints = false
        inputField.textColor = UIColor.black
        inputField.placeholder = "Gentag Password"
        inputField.textColor = UIColor.black
        inputField.font = UIFont(name: "MarkerFelt-Thin", size: 20)
        inputField.backgroundColor = UIColor.lightGray
        inputField.layer.cornerRadius = 3
        return inputField
    }()
    
    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [emailInputField, passwordInputField, passwordRepeatInputField])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .top
        stackView.spacing = 35
        return stackView
    }()
    
    private lazy var createButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.text = "Opret"
        button.titleLabel?.textColor = UIColor.black
        button.titleLabel?.font = UIFont(name: "MarkerFelt-Thin", size: 20)
        button.backgroundColor = UIColor.lightGray
        button.layer.cornerRadius = 3
        return button
    }()
    
    // MARK: Setup SubViews
    func setupSubViews() {
        [brainImage, contentStackView, createButton].forEach({self.addSubview($0)})
        
        setupConstraints()
    }
    
    func setupConstraints() {
        
        
    }
}
