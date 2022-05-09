//
//  CreateUserView.swift
//  SymptomTrackerIOS
//
//  Created by Kira Nim on 08/05/2022.
//

import Foundation
import UIKit
import SwiftUI

class CreateUserView: UIView {
    
    // MARK: subviews
    
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setTitle("╳✕✖⨉⨯", for: .normal)
        button.titleLabel?.font = UIFont(name: "San Francisco", size: 17)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.bold)
        button.setTitleColor(UIColor.black, for: .normal)
        return button
    }()
    
    private lazy var brainImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "Logo"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var imageContentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var emailInputField: UITextField = {
        let inputField =  createInputFieldWith(placeholderText: "Email")
        return inputField
    }()
    
    private lazy var passwordInputField: UITextField = {
        let inputField = createInputFieldWith(placeholderText: "Password")
        return inputField
    }()
    
    private lazy var passwordRepeatInputField: UITextField = {
        let inputField = createInputFieldWith(placeholderText: "Gentag Password")
        return inputField
    }()
    
    private lazy var createButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Opret", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "San Francisco", size: 17)
        //button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.bold)
        button.backgroundColor = UIColor.white
        button.layer.cornerRadius = 3
        return button
    }()
    
    private lazy var contentStackView: UIStackView = {
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
    
    //MARK: super init
    init() {
        /*
         The frame of the super view to this view, is temperarily set to zero until this view is placed into the view hierarchy and this this super view gets its real freme bounds from the OS (when the controller ordered to show its view)
         */
        super.init(frame: CGRect.zero)
        backgroundColor = UIColor.white
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
        
        [imageContentView, contentStackView, createButton, closeButton].forEach({self.addSubview($0)})

    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            imageContentView.topAnchor.constraint(equalTo: self.topAnchor),
            imageContentView.bottomAnchor.constraint(equalTo: contentStackView.topAnchor, constant: -50),
            imageContentView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 33),
            imageContentView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -33),
            
            brainImage.centerYAnchor.constraint(equalTo: imageContentView.centerYAnchor, constant: 40),
            brainImage.centerXAnchor.constraint(equalTo: imageContentView.centerXAnchor),
            brainImage.heightAnchor.constraint(lessThanOrEqualToConstant: 135),
            
            closeButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10),
            closeButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: 10),
            closeButton.heightAnchor.constraint(equalToConstant: 10),
            
            contentStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 70),
            contentStackView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 33),
            contentStackView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -33),
            contentStackView.heightAnchor.constraint(equalToConstant: 161),
            
            createButton.heightAnchor.constraint(equalToConstant: 48),
            createButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 33),
            createButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -33),
            createButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -40),
        ])
    }
    
    //MARK: Help functions
    
    // Helpfunction for creating textField subclasses
    private func createInputFieldWith(placeholderText: String) -> UITextField {
        let inputField = UITextField()
        
        inputField.translatesAutoresizingMaskIntoConstraints = false
        inputField.textColor = UIColor.black
        inputField.font = UIFont(name: "San Francisco", size: 17)
        inputField.layer.cornerRadius = 3
        inputField.layer.borderWidth = 1
        inputField.layer.borderColor = UIColor.lightGray.cgColor
        inputField.placeholder = placeholderText
        inputField.backgroundColor = UIColor.white
        inputField.layer.cornerRadius = 3
        inputField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 13, height: 1))
        inputField.leftViewMode = .always
        
        return inputField
    }
}
