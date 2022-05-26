//
//  SymptomRegistrationView.swift
//  SymptomTrackerIOS
//
//  Created by Kira Nim on 15/05/2022.
//

import Foundation
import UIKit

class SymptomRegistrationView: UIView {
    
    // MARK: Subviews
    public var registrationTableView = UITableView()
    
    // MARK: Init
    init() {
        super.init(frame: CGRect.zero)
        backgroundColor = UIColor.appColor(name: .backgroundColor)
        
        setAttributesOnSubViews()
        setupSubViews()
        setupConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Set attributes on subviews
    private func setAttributesOnSubViews() {
        registrationTableView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    // MARK: Setup subviews
    private func setupSubViews() {
        self.addSubview(registrationTableView)
    }
    
    // MARK: Setup constraints
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            registrationTableView.topAnchor.constraint(equalTo: self.topAnchor),
            registrationTableView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            registrationTableView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            registrationTableView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}
