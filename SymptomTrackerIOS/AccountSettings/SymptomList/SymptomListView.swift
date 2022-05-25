//
//  SymptomListView.swift
//  SymptomTrackerIOS
//
//  Created by Kira Nim on 21/05/2022.
//

import Foundation
import UIKit

final class SymptomListView: UIView {
    
    public var buttonContentViewConstraint: NSLayoutConstraint? = nil
    public var createSymptomButtonViewConstraint: NSLayoutConstraint? = nil
    
    public lazy var symptomsTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    public lazy var buttonContentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.appColor(name: .sectionBacgroundColor)
        return view
    }()
    
    public lazy var createSymptomButtonView: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(LocalizedStrings.shared.createSymptomButtonText, for: .normal)
        button.setTitleColor(UIColor.appColor(name: .buttonBlueTextColor), for: .normal)
        button.titleLabel?.font = .appFont(ofSize: 17, weight: .medium)
        button.backgroundColor = .appColor(name: .buttonBlue)
        button.setBackgroundImage(UIColor.appColor(name: .buttonBlueClicked).image(), for: .highlighted)
        button.layer.cornerRadius = 3
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.appColor(name: .buttonBlueBorderColor).cgColor
        return button
    }()
    
    init() {
        /*
        The frame of the super view to this view, is temperarily set to zero
         until this view is placed into the view hierarchy and this this super
         view gets its real freme bounds from the OS (when the controller ordered to show its view)
        */
        super.init(frame: CGRect.zero)
        backgroundColor = UIColor.appColor(name: .backgroundColor)
        
        // Because we only want these elements to be shown to user when list is in editing stete
        self.buttonContentViewConstraint = buttonContentView.heightAnchor.constraint(equalToConstant: 0)
        self.createSymptomButtonViewConstraint = createSymptomButtonView.heightAnchor.constraint(equalToConstant: 0)

        setupSubViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubViews() {
        buttonContentView.addSubview(createSymptomButtonView)
        [buttonContentView, symptomsTableView].forEach({self.addSubview($0)})
    }
    
    private func setupConstraints() {
        if let buttonContentViewConstraint = buttonContentViewConstraint,
           let createSymptomButtonViewConstraint = createSymptomButtonViewConstraint {
            
            NSLayoutConstraint.activate([buttonContentViewConstraint, createSymptomButtonViewConstraint])
        }
        
        NSLayoutConstraint.activate([
            buttonContentView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            buttonContentView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            buttonContentView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            
            createSymptomButtonView.leadingAnchor.constraint(equalTo: buttonContentView.leadingAnchor, constant: 115),
            createSymptomButtonView.trailingAnchor.constraint(equalTo: buttonContentView.trailingAnchor, constant: -115),
            createSymptomButtonView.centerYAnchor.constraint(equalTo: buttonContentView.centerYAnchor, constant: 3),
            
            symptomsTableView.topAnchor.constraint(equalTo: buttonContentView.bottomAnchor),
            symptomsTableView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            symptomsTableView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            symptomsTableView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
