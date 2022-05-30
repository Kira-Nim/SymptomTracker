//
//  symptomRegistrationCell.swift
//  SymptomTrackerIOS
//
//  Created by Kira Nim on 26/05/2022.
//

import Foundation
import UIKit
import SwiftUI

class SymptomRegistrationCell: UITableViewCell {
    private var symptomRegistration: SymptomRegistration?
    
    // MARK: Subviews
    public var oneCollectedRegistrationButton = UIButton()
    public var registrationButtonMorning = UIButton()
    public var registrationButtonMidday = UIButton()
    public var registrationButtonEvening = UIButton()
    public var registrationButtonBedTime = UIButton()
    public var resetRegistrationsButton = UIButton()
    public var symptomNameLabel = UILabel()
    
    public lazy var cellContentStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [registrationButtonMorning,
                                                       registrationButtonMidday,
                                                       registrationButtonEvening,
                                                       registrationButtonBedTime ])
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .leading
        //stackView.spacing = 10
        return stackView
    }()
    
    // MARK: - Initializer
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setAttributesOnSubViews()
        setupSubViews()
        setupConstraints()
        
        //Turn off default way of showing that row has been selected
        self.selectionStyle = .none
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Set attributes on subviews
    private func setAttributesOnSubViews() {
        
        registrationButtonMorning.backgroundColor = UIColor.orange
        setButtonattributes(button: registrationButtonMorning, color: .registrationNeutral)
        registrationButtonMorning.setBackgroundImage(UIImage(named: "SunRise"), for: .normal)
        
        registrationButtonMidday.backgroundColor = UIColor.orange
        setButtonattributes(button: registrationButtonMidday, color: .registrationOrange)
        registrationButtonMidday.setBackgroundImage(UIImage(named: "Sun"), for: .normal)
        
        registrationButtonEvening.backgroundColor = UIColor.orange
        setButtonattributes(button: registrationButtonEvening, color: .registrationYellow)
        registrationButtonEvening.setBackgroundImage(UIImage(named: "SunSet"), for: .normal)
        
        registrationButtonBedTime.backgroundColor = UIColor.orange
        setButtonattributes(button: registrationButtonBedTime, color: .registrationGreen)
        registrationButtonBedTime.setBackgroundImage(UIImage(named: "Moon_2"), for: .normal)
        
        oneCollectedRegistrationButton.backgroundColor = UIColor.red
        oneCollectedRegistrationButton.setTitle(LocalizedStrings.shared.AllDayRegistrationButtonText, for: .normal)
        oneCollectedRegistrationButton.setTitleColor(UIColor.appColor(name: .registrationButtonText), for: .normal)
        oneCollectedRegistrationButton.titleLabel?.font = .appFont(ofSize: 15, weight: .medium)
        setButtonattributes(button: oneCollectedRegistrationButton, color: .registrationRed)
        
        resetRegistrationsButton.translatesAutoresizingMaskIntoConstraints = false
        resetRegistrationsButton.backgroundColor = UIColor.appColor(name: .registrationNeutral)
        resetRegistrationsButton.setBackgroundImage(UIColor.appColor(name: .registrationNeutral).image(), for: .highlighted)
        resetRegistrationsButton.layer.cornerRadius = 15.5
        resetRegistrationsButton.layer.borderWidth = 1
        resetRegistrationsButton.layer.borderColor = UIColor.appColor(name: .registrationButtonBorderColor).cgColor
        resetRegistrationsButton.setBackgroundImage(UIImage(named: "ResetRegistrations_x"), for: .normal)
        
        symptomNameLabel.translatesAutoresizingMaskIntoConstraints = false
        symptomNameLabel.text = symptomRegistration?.symptom?.name
        symptomNameLabel.numberOfLines = 0
        symptomNameLabel.textColor = .appColor(name: .textBlack)
        symptomNameLabel.font = .appFont(ofSize: 19, weight: .medium)
        symptomNameLabel.textAlignment = NSTextAlignment.left
        
    }
    
    // MARK: Setup subviews
    private func setupSubViews() {[oneCollectedRegistrationButton,
                                   symptomNameLabel,
                                   cellContentStackView,
                                   resetRegistrationsButton ].forEach({self.contentView.addSubview($0)})
    }
    
    // MARK: Setup constraints
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            oneCollectedRegistrationButton.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -24),
            oneCollectedRegistrationButton.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 17),
            oneCollectedRegistrationButton.trailingAnchor.constraint(equalTo: cellContentStackView.leadingAnchor, constant: -40),
            oneCollectedRegistrationButton.heightAnchor.constraint(equalToConstant: 30),
            oneCollectedRegistrationButton.widthAnchor.constraint(equalToConstant: 90),
            
            cellContentStackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            cellContentStackView.topAnchor.constraint(equalTo: symptomNameLabel.bottomAnchor, constant: 9),
            cellContentStackView.heightAnchor.constraint(equalToConstant: 35),
            
            symptomNameLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
            symptomNameLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 17),
            symptomNameLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor,constant: -20),
            symptomNameLabel.heightAnchor.constraint(equalToConstant: 25),
            
            registrationButtonMorning.heightAnchor.constraint(equalToConstant: 30),
            registrationButtonMorning.widthAnchor.constraint(equalToConstant: 30),
            
            registrationButtonMidday.heightAnchor.constraint(equalToConstant: 30),
            registrationButtonMidday.widthAnchor.constraint(equalToConstant: 30),
            
            registrationButtonEvening.heightAnchor.constraint(equalToConstant: 30),
            registrationButtonEvening.widthAnchor.constraint(equalToConstant: 30),
            
            registrationButtonBedTime.heightAnchor.constraint(equalToConstant: 30),
            registrationButtonBedTime.widthAnchor.constraint(equalToConstant: 30),
            
            resetRegistrationsButton.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -23),
            resetRegistrationsButton.heightAnchor.constraint(equalToConstant: 31),
            resetRegistrationsButton.widthAnchor.constraint(equalToConstant: 31),
            resetRegistrationsButton.leadingAnchor.constraint(equalTo: cellContentStackView.trailingAnchor, constant: 25),
            resetRegistrationsButton.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor,constant: -15)
        ])
    }
    
    // MARK: Confuguration for cell
    public func configureCell(symptomRegistration: SymptomRegistration) {
        self.symptomRegistration = symptomRegistration
    }
    
    private func setButtonattributes(button: UIButton, color: UIColor.AppColor) {
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor.appColor(name: color)
        button.setBackgroundImage(UIColor.appColor(name: color).image(), for: .highlighted)
        button.layer.cornerRadius = 3
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.appColor(name: .registrationButtonBorderColor).cgColor
    }
}
