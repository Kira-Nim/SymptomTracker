//
//  navbarView.swift
//  SymptomTrackerIOS
//
//  Created by Kira Nim on 27/05/2022.
//

import Foundation
import UIKit

class SymptomRegistrationNavbarView: UIView {
    public var changeDateCallback: ((Date) -> Void)?
    public var dateString: String?
    public var date = Date()

    // MARK: Subviews
    public var calenderbuttonRigh = UIButton()
    public var calenderbuttonLeft = UIButton()
    public var datePicker = UIDatePicker()
    public var datePickerOverlay = UILabel()
    
    // MARK: Init
    init() {
        super.init(frame: CGRect.zero)
        backgroundColor = .clear
        setAttributesOnSubViews()
        setupSubViews()
        setupConstraints()
        
        setActionOnCalenderButtons(calenderButton: calenderbuttonRigh, dateModerator: 1)
        setActionOnCalenderButtons(calenderButton: calenderbuttonLeft, dateModerator: -1)
        datePicker.addTarget(self, action: #selector(newDateChosen), for: .valueChanged)
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
        
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.preferredDatePickerStyle = .compact
        datePicker.datePickerMode = .date
        
        datePickerOverlay.translatesAutoresizingMaskIntoConstraints = false
        datePickerOverlay.numberOfLines = 0
        datePickerOverlay.textColor = .appColor(name: .dateLabelColor)
        

        
        datePickerOverlay.text = ""
        gfiqgwrfiuqgrfiqgri
        
        
        
        datePickerOverlay.font = .appFont(ofSize: 25, weight: .bold)
        datePickerOverlay.textAlignment = NSTextAlignment.center
        datePickerOverlay.backgroundColor = UIColor.appColor(name: .buttonColor)
        datePickerOverlay.layer.cornerRadius = 18
        datePickerOverlay.layer.borderWidth = 0.5
        datePickerOverlay.layer.borderColor = UIColor.appColor(name: .registrationButtonBorderColor).cgColor
        datePickerOverlay.layer.masksToBounds = true
    }
    
    // MARK: Setup subviews
    private func setupSubViews() {[calenderbuttonLeft,
                                   datePicker,
                                   datePickerOverlay,
                                   calenderbuttonRigh].forEach({self.addSubview($0)})
        
        self.bringSubviewToFront(datePickerOverlay)
    }
    
    // MARK: Setup constraints
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            self.widthAnchor.constraint(equalToConstant: 200),
            self.heightAnchor.constraint(equalToConstant: 42),

            datePicker.topAnchor.constraint(equalTo: self.topAnchor),
            datePicker.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -2),
            datePicker.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            datePickerOverlay.topAnchor.constraint(equalTo: self.topAnchor),
            datePickerOverlay.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -2),
            datePickerOverlay.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            datePickerOverlay.widthAnchor.constraint(equalToConstant: 133),
            
            calenderbuttonLeft.topAnchor.constraint(equalTo: self.topAnchor),
            calenderbuttonLeft.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            calenderbuttonLeft.trailingAnchor.constraint(equalTo: datePicker.leadingAnchor, constant: -30),
            
            calenderbuttonRigh.leadingAnchor.constraint(equalTo: datePicker.trailingAnchor, constant: 30),
            calenderbuttonRigh.topAnchor.constraint(equalTo: self.topAnchor),
            calenderbuttonRigh.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    // MARK: Register action on date picker and datepicker arrow buttons
    
    /* Method for setting action that activates callback when calenderbutton is pressed.
       datemoderator is a value representing the number of dates to be added to current date to get selected date
       The callback will activate SymptomRegistrationViewModel who will change its chosen dat att to another date,
       thereby triggering a rotation of content in registration lists.
     */
    private func setActionOnCalenderButtons(calenderButton: UIButton, dateModerator: Int) {
        calenderButton.addAction(UIAction {[weak self] _ in
            if let date = self?.date,
               let newDate = Calendar.current.date(byAdding: .day, value: dateModerator, to: date) {
                    self?.changeDateCallback?(newDate)
                    self?.date = newDate
            }
        }, for: .touchUpInside)
    }
    
    @objc
    func newDateChosen() {
        let newDate = self.datePicker.date
            changeDateCallback?(newDate)
            date = newDate
    }
}
