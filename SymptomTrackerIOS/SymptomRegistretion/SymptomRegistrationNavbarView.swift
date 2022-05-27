//
//  navbarView.swift
//  SymptomTrackerIOS
//
//  Created by Kira Nim on 27/05/2022.
//

import Foundation
import UIKit

class SymptomRegistrationNavbarView: UIView {
    
    // MARK: Subviews
    public var calenderbuttonRigh = UIButton()
    public var calenderbuttonLeft = UIButton()
    public var calenderDateLabel = UILabel()

    
    // MARK: Init
    init() {
        super.init(frame: CGRect.zero)
        backgroundColor = .clear
        setAttributesOnSubViews()
        setupSubViews()
        setupConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Set attributes on subviews
    private func setAttributesOnSubViews() {
        calenderbuttonRigh.translatesAutoresizingMaskIntoConstraints = false
        calenderbuttonRigh.setBackgroundImage(UIImage(named: "Arrow_right"), for: .normal)
        
        calenderbuttonLeft.translatesAutoresizingMaskIntoConstraints = false
        calenderbuttonLeft.setBackgroundImage(UIImage(named: "Arrow_left"), for: .normal)
        
        calenderDateLabel.translatesAutoresizingMaskIntoConstraints = false
        calenderDateLabel.numberOfLines = 0
        calenderDateLabel.textColor = .appColor(name: .dateLabelColor)
        calenderDateLabel.text = "21 Maj"
        calenderDateLabel.font = .appFont(ofSize: 25, weight: .bold)
        calenderDateLabel.textAlignment = NSTextAlignment.center
    }
    
    // MARK: Setup subviews
    private func setupSubViews() {[calenderbuttonLeft,
                                   calenderDateLabel,
                                   calenderbuttonRigh].forEach({self.addSubview($0)})
    }
    
    // MARK: Setup constraints
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            self.widthAnchor.constraint(equalToConstant: 200),
            self.heightAnchor.constraint(equalToConstant: 42),

            calenderDateLabel.topAnchor.constraint(equalTo: self.topAnchor),
            calenderDateLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            calenderDateLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            calenderbuttonLeft.topAnchor.constraint(equalTo: self.topAnchor),
            calenderbuttonLeft.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            calenderbuttonLeft.trailingAnchor.constraint(equalTo: calenderDateLabel.leadingAnchor, constant: -30),
            
            calenderbuttonRigh.leadingAnchor.constraint(equalTo: calenderDateLabel.trailingAnchor, constant: 30),
            calenderbuttonRigh.topAnchor.constraint(equalTo: self.topAnchor),
            calenderbuttonRigh.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
