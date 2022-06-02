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
    private var presentRegistrationIntensityCallback: ((Int?) -> UIColor)?
    
    // MARK: Subviews
    public var oneCollectedRegistrationButton = UIButton()
    public var registrationButtonMorning = UIButton()
    public var registrationButtonMidday = UIButton()
    public var registrationButtonEvening = UIButton()
    public var registrationButtonBedTime = UIButton()
    public var resetRegistrationsButton = UIButton()
    public var symptomNameLabel = UILabel()
    private var registrationButtonArray: [UIButton] = []
    
    public lazy var cellContentStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [registrationButtonMorning,
                                                       registrationButtonMidday,
                                                       registrationButtonEvening,
                                                       registrationButtonBedTime ])
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .leading
        return stackView
    }()
    
    // MARK: - Initializer
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor.appColor(name: .backgroundColor)
        
        registrationButtonArray = [registrationButtonBedTime, registrationButtonEvening, registrationButtonMidday, registrationButtonMorning]
        setAttributesOnSubViews()
        setupSubViews()
        setupConstraints()
        addFunctionalityToIntensityRegistrationButtons()
        
        //Turn off default way of showing that row has been selected
        self.selectionStyle = .none
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Set attributes on subviews
    private func setAttributesOnSubViews() {
        
        registrationButtonMorning.setBackgroundImage(UIImage(named: "SunRise"), for: .normal)
        registrationButtonMidday.setBackgroundImage(UIImage(named: "Sun"), for: .normal)
        registrationButtonEvening.setBackgroundImage(UIImage(named: "SunSet"), for: .normal)
        registrationButtonBedTime.setBackgroundImage(UIImage(named: "Moon_1"), for: .normal)
        registrationButtonArray.enumerated().forEach({
            setButtonAttributesOn(button: $1, intensity: symptomRegistration?.intensityRegistrationList[$0].intensity)
        })
        
        oneCollectedRegistrationButton.setTitle(LocalizedStrings.shared.AllDayRegistrationButtonText, for: .normal)
        oneCollectedRegistrationButton.setTitleColor(UIColor.appColor(name: .registrationButtonText), for: .normal)
        oneCollectedRegistrationButton.titleLabel?.font = .appFont(ofSize: 15, weight: .medium)
        setButtonAttributesOn(button: oneCollectedRegistrationButton, intensity: symptomRegistration?.intensityRegistrationAverage)
        
        resetRegistrationsButton.translatesAutoresizingMaskIntoConstraints = false
        resetRegistrationsButton.backgroundColor = UIColor.appColor(name: .registrationWhite)
        resetRegistrationsButton.setBackgroundImage(UIColor.appColor(name: .registrationWhite).image(), for: .highlighted)
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
    public func configureCell(symptomRegistration: SymptomRegistration, presentRegistrationIntensityCallback: @escaping (Int?) -> UIColor) {
        self.symptomRegistration = symptomRegistration
        self.presentRegistrationIntensityCallback = presentRegistrationIntensityCallback
        setAttributesOnSubViews()
    }
    
    // MARK: updateCell()
    public func addFunctionalityToIntensityRegistrationButtons() {
        registrationButtonArray.enumerated().forEach({
            addActionTo(registrationButton: $1, dailyIntensityRegistrationNumber: $0)
        })
        addActionTo(collectiveRegistrationButton: oneCollectedRegistrationButton)
    }
    
    // MARK: Helpfunctions for setting attributes on subviews
    private func setButtonAttributesOn(button: UIButton, intensity: Int?) {
        setColor(button: button, intensity: intensity)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 4
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.appColor(name: .registrationButtonBorderColor).cgColor
    }
    
    private func setColor(button: UIButton, intensity: Int?) {
        //This function takes an Int an intensity value (Int) and returns a color (UIColor)
        guard let color = presentRegistrationIntensityCallback?(intensity) else { return }
        button.backgroundColor = color
        button.setBackgroundImage(color.image(), for: .highlighted)
    }
    
    /* Method for setting the response to a click event on the daily registration buttens
       (not incl. the oneCollectedRegistrationButton)
       When button is clicked this wil happen. The intensity level will go one up.
       If intensity level is the heigest level (3) then the intensity will be set to the lowest level (0)
     */
    private func addActionTo(registrationButton: UIButton, dailyIntensityRegistrationNumber: Int ) {
        registrationButton.addAction(UIAction {[weak self] _ in
            self?.updateIntensityOnRegistrationFor(dailyIntensityRegistrationNumber: dailyIntensityRegistrationNumber, registrationButton: registrationButton)
        }, for: .touchUpInside)
    }
    
    private func updateIntensityOnRegistrationFor(dailyIntensityRegistrationNumber: Int, registrationButton: UIButton) {
        
        // If the intensity id nil (there has been no registrations) then the intensity will be converted to a -1 value.
        // When this value is operated on later (+1) then it will be set to 0 whitch is what we want.
        let currentIntensityLevel = symptomRegistration?.intensityRegistrationList[dailyIntensityRegistrationNumber].intensity ?? -1
        
        // Every possible value number except 4 will become 1 bigger (Fx. 2 % 5 = 2 -> 2 + 1 = 3) except 4 because (4+1) % 5 is 0.
        // We want 4 to become zero and the others to become them selves plus 1.
        let newIntensityLevel = (currentIntensityLevel + 1) % 5
        
        symptomRegistration?.intensityRegistrationList[dailyIntensityRegistrationNumber].intensity = newIntensityLevel
        setColor(button: registrationButton, intensity: newIntensityLevel)
        updateAverageIntensityOnRegistration(intensityLevel: symptomRegistration?.intensityRegistrationAverage)
    }
    
    // Method for setting the response to a click event on the collective registration button
    private func addActionTo(collectiveRegistrationButton: UIButton) {
        collectiveRegistrationButton.addAction(UIAction {[weak self] _ in
            var newIntensityLevel: Int? = nil
            if let currentIntensityLevel = self?.symptomRegistration?.intensityRegistrationAverage {
                newIntensityLevel = (currentIntensityLevel + 1) % 5
            }
            self?.updateAverageIntensityOnRegistration(intensityLevel: newIntensityLevel)
            
            // Set intensity on all intensityregistrations to match the average intensity
            // Update the buttons to reflect change.
            self?.registrationButtonArray.enumerated().forEach {
                self?.symptomRegistration?.intensityRegistrationList[$0].intensity = newIntensityLevel
                self?.updateIntensityOnRegistrationFor(dailyIntensityRegistrationNumber: $0, registrationButton: $1)
            }
            
        }, for: .touchUpInside)
    }
    
    // Helpfunction for calculating a average for the collective symptom registrations.
    // Executed as callback when a registration button is tapped in cell.
    private func updateAverageIntensityOnRegistration(intensityLevel: Int?) {
        var intensityLevel = intensityLevel
        
        if let intensityRegistrationList = symptomRegistration?.intensityRegistrationList {
            
            // Filter out all intensityRegistrations that have a nil intensity. Get a list of intensities.
            let intensityListWithoutNilValues = intensityRegistrationList.compactMap({
                $0.intensity
            })
            
            // Get sum of intensity
            var intensitySum: Int = 0
            intensityListWithoutNilValues.forEach({
                intensitySum += $0
            })

            // Get average intensity based only on non-nil values of intensity.
            // If average is more than 0, and les than 1 then always round up. Else standard rounding pattern
            if intensityListWithoutNilValues.count != 0 {
                let intensityLevelDouble: Double = Double(intensitySum) / Double(intensityListWithoutNilValues.count)
                if (intensityLevelDouble > 0 && intensityLevelDouble <= 1 ) {
                    intensityLevel = 1
                } else {
                    intensityLevel = Int(round(intensityLevelDouble))
                }
            } else {
                intensityLevel = nil
            }
        }
        setColor(button: oneCollectedRegistrationButton, intensity: intensityLevel)
    }
}


