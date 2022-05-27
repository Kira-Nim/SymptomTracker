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
        let stackView = UIStackView(arrangedSubviews: [
                                            oneCollectedRegistrationButton,
                                            registrationButtonMorning,
                                            registrationButtonMidday,
                                            registrationButtonEvening,
                                            registrationButtonBedTime,
                                            resetRegistrationsButton ])
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.alignment = .leading
        stackView.spacing = 10
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
        registrationButtonMidday.translatesAutoresizingMaskIntoConstraints = false
        registrationButtonEvening.translatesAutoresizingMaskIntoConstraints = false
        registrationButtonBedTime.translatesAutoresizingMaskIntoConstraints = false
        oneCollectedRegistrationButton.translatesAutoresizingMaskIntoConstraints = false
        resetRegistrationsButton.translatesAutoresizingMaskIntoConstraints = false
        
        symptomNameLabel.translatesAutoresizingMaskIntoConstraints = false
        symptomNameLabel.text = symptom?.name
    }
    
    // MARK: Setup subviews
    private func setupSubViews() {
        [symptomNameLabel, cellContentStackView].forEach({
            self.contentView.addSubview($0)})
    }
    
    // MARK: Setup constraints
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            cellContentStackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            cellContentStackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            cellContentStackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            
            symptomNameLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            symptomNameLabel.bottomAnchor.constraint(equalTo: self.cellContentStackView.topAnchor),
            symptomNameLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            symptomNameLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            symptomNameLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    // MARK: Confuguration for cell
    public func configureCell(symptom: Symptom) {
        self.symptom = symptom
    }
}
