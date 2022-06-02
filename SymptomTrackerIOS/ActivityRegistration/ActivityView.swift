//
//  ActivityView.swift
//  SymptomTrackerIOS
//
//  Created by Kira Nim on 15/05/2022.
//

import Foundation
import UIKit

class ActivityView: UIView {
    public var buttonContentViewConstraint: NSLayoutConstraint?
    public var createActivityButtonViewConstraint: NSLayoutConstraint?
    
    // MARK: Subviews
    public var activityTableView = UITableView()
    public var createActivityButtonView = UIButton()
    
    public lazy var buttonContentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.appColor(name: .sectionBacgroundColor)
        return view
    }()
    
    // MARK: Init
    init() {
        super.init(frame: CGRect.zero)
        backgroundColor = UIColor.appColor(name: .backgroundColor)
        
        // Because we only want these elements to be shown to user when list is in editing stete
        self.buttonContentViewConstraint = buttonContentView.heightAnchor.constraint(equalToConstant: 0)
        self.createActivityButtonViewConstraint = createActivityButtonView.heightAnchor.constraint(equalToConstant: 0)
        
        setAttributesOnSubViews()
        setupSubViews()
        setupConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Set attributes on subviews
    private func setAttributesOnSubViews() {
        activityTableView.translatesAutoresizingMaskIntoConstraints = false
        activityTableView.backgroundColor = UIColor.appColor(name: .backgroundColor)
        
        createActivityButtonView.translatesAutoresizingMaskIntoConstraints = false
        createActivityButtonView.setTitle(LocalizedStrings.shared.createActivityButtonText, for: .normal)
        createActivityButtonView.setTitleColor(UIColor.appColor(name: .buttonTextColor), for: .normal)
        createActivityButtonView.titleLabel?.font = .appFont(ofSize: 18, weight: .medium)
        createActivityButtonView.backgroundColor = .appColor(name: .buttonColor)
        createActivityButtonView.setBackgroundImage(UIColor.appColor(name: .buttonClicked).image(), for: .highlighted)
        createActivityButtonView.layer.cornerRadius = 4
        createActivityButtonView.layer.borderWidth = 0.5
        createActivityButtonView.layer.borderColor = UIColor.appColor(name: .buttonBorderColor).cgColor
        
    }
    // MARK: Setup subviews
    private func setupSubViews() {
        buttonContentView.addSubview(createActivityButtonView)
        [buttonContentView, activityTableView].forEach({self.addSubview($0)})

    }
    
    // MARK: Setup constraints
    private func setupConstraints() {
        if let buttonContentViewConstraint = buttonContentViewConstraint,
           let createActivityButtonViewConstraint = createActivityButtonViewConstraint {
            NSLayoutConstraint.activate([buttonContentViewConstraint, createActivityButtonViewConstraint])
        }
        NSLayoutConstraint.activate([
            buttonContentView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 5),
            buttonContentView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            buttonContentView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            
            createActivityButtonView.leadingAnchor.constraint(equalTo: buttonContentView.leadingAnchor, constant: 115),
            createActivityButtonView.trailingAnchor.constraint(equalTo: buttonContentView.trailingAnchor, constant: -115),
            createActivityButtonView.centerYAnchor.constraint(equalTo: buttonContentView.centerYAnchor, constant: 3),
            
            activityTableView.topAnchor.constraint(equalTo: buttonContentView.bottomAnchor),
            activityTableView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            activityTableView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            activityTableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}

