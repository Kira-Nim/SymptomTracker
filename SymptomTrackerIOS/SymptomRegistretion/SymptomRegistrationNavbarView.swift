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
    public var calenderPickerView = UIImageView()
    
    public lazy var calenderPickerContentStackView: UIStackView = {
       let stackView = UIStackView(arrangedSubviews: [calenderbuttonLeft,
                                                      calenderPickerView,
                                                      calenderbuttonRigh ])

        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.alignment = .center
        //stackView.spacing =
        return stackView
    }()
    
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
        calenderbuttonRigh.translatesAutoresizingMaskIntoConstraints = false
        calenderbuttonRigh.setBackgroundImage(UIImage(named: "Arror_right"), for: .normal)
        
        calenderbuttonLeft.translatesAutoresizingMaskIntoConstraints = false
        calenderbuttonLeft.setBackgroundImage(UIImage(named: "Arror_left"), for: .normal)
        calenderPickerView.translatesAutoresizingMaskIntoConstraints = false
        calenderPickerView.image = UIImage(named: "Calender")
    }
    
    // MARK: Setup subviews
    private func setupSubViews() {
        self.addSubview(calenderPickerContentStackView)
    }
    
    // MARK: Setup constraints
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            self.widthAnchor.constraint(equalToConstant: 200),
            self.heightAnchor.constraint(equalToConstant: 40),
            calenderPickerContentStackView.topAnchor.constraint(equalTo: self.topAnchor),
            calenderPickerContentStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            calenderPickerContentStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            calenderPickerContentStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
    }
}
