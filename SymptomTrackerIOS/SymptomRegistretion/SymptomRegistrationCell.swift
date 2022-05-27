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
    private var symptom: Symptom?
    
    // MARK: Subviews
    public var oneCollectedRegistrationButton = UIButton()
    public var registrationButtonMorning = UIButton()
    public var registrationButtonMidday = UIButton()
    public var registrationButtonEvening = UIButton()
    public var registrationButtonBedTime = UIButton()
    public var resetRegistrationsButton = UIButton()
    public var symptomNameLabel = UILabel()
    
    public lazy var cellContentStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [oneCollectedRegistrationButton,
                                                       registrationButtonMorning,
                                                       registrationButtonMidday,
                                                       registrationButtonEvening,
                                                       registrationButtonBedTime,
                                                       resetRegistrationsButton ])
        
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
        registrationButtonMorning.translatesAutoresizingMaskIntoConstraints = false
        registrationButtonMorning.backgroundColor = UIColor.orange
        
        registrationButtonMidday.translatesAutoresizingMaskIntoConstraints = false
        registrationButtonMidday.backgroundColor = UIColor.orange
        
        registrationButtonEvening.translatesAutoresizingMaskIntoConstraints = false
        registrationButtonEvening.backgroundColor = UIColor.orange
        
        registrationButtonBedTime.translatesAutoresizingMaskIntoConstraints = false
        registrationButtonBedTime.backgroundColor = UIColor.orange
        
        oneCollectedRegistrationButton.translatesAutoresizingMaskIntoConstraints = false
        oneCollectedRegistrationButton.backgroundColor = UIColor.red
        
        /*
        resetButton.setTitle(LocalizedStrings.shared.resetPasswordButtonText, for: .normal)
        resetButton.setTitleColor(UIColor.white, for: .normal)
        resetButton.titleLabel?.font = .appFont(ofSize: 17, weight: .medium)
        resetButton.backgroundColor = .appColor(name: .buttonBlue)
        resetButton.setBackgroundImage(UIColor.appColor(name: .buttonBlueClicked).image(), for: .highlighted)
        resetButton.layer.cornerRadius = 3
        resetButton.layer.borderWidth = 1
        resetButton.layer.borderColor = UIColor.appColor(name: .buttonBlueBorderColor).cgColor
        */
        
        resetRegistrationsButton.translatesAutoresizingMaskIntoConstraints = false
        resetRegistrationsButton.backgroundColor = UIColor.yellow
        
        symptomNameLabel.translatesAutoresizingMaskIntoConstraints = false
        symptomNameLabel.text = "symptom?.name"
        symptomNameLabel.numberOfLines = 0
        symptomNameLabel.textColor = .appColor(name: .textBlack)
        symptomNameLabel.font = .appFont(ofSize: 19, weight: .medium)
        symptomNameLabel.textAlignment = NSTextAlignment.left
        
    }
    
    // MARK: Setup subviews
    private func setupSubViews() {[symptomNameLabel,
                                   cellContentStackView].forEach({self.contentView.addSubview($0)})
    }
    
    // MARK: Setup constraints
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            cellContentStackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20),
            cellContentStackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20),
            cellContentStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            cellContentStackView.topAnchor.constraint(equalTo: symptomNameLabel.bottomAnchor, constant: 10),
            cellContentStackView.heightAnchor.constraint(equalToConstant: 35),
            
            symptomNameLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 6),
            symptomNameLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20),
            symptomNameLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor,constant: -20),
            symptomNameLabel.heightAnchor.constraint(equalToConstant: 25),
            
            registrationButtonMorning.heightAnchor.constraint(equalToConstant: 25),
            registrationButtonMorning.widthAnchor.constraint(equalToConstant: 25),
            
            registrationButtonMidday.heightAnchor.constraint(equalToConstant: 25),
            registrationButtonMidday.widthAnchor.constraint(equalToConstant: 25),
            
            registrationButtonEvening.heightAnchor.constraint(equalToConstant: 25),
            registrationButtonEvening.widthAnchor.constraint(equalToConstant: 25),
            
            registrationButtonBedTime.heightAnchor.constraint(equalToConstant: 25),
            registrationButtonBedTime.widthAnchor.constraint(equalToConstant: 25),
            
            oneCollectedRegistrationButton.heightAnchor.constraint(equalToConstant: 25),
            oneCollectedRegistrationButton.widthAnchor.constraint(equalToConstant: 80),
            
            resetRegistrationsButton.heightAnchor.constraint(equalToConstant: 25),
            resetRegistrationsButton.widthAnchor.constraint(equalToConstant: 25),
            
        ])
    }
    // MARK: Confuguration for cell
    public func configureCell(symptom: Symptom) {
        self.symptom = symptom
    }
}
