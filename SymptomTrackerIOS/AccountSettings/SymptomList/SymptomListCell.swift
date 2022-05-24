//
//  SymptomListCell.swift
//  SymptomTrackerIOS
//
//  Created by Kira Nim on 21/05/2022.
//

import Foundation
import UIKit

class SymptomListCell: UITableViewCell {
    
    private var symptom: Symptom?
    private var switchCallback: ((Symptom) -> Void)? = nil
    
    //MARK: Subviews
    public lazy var symptomLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = .appFont(ofSize: 17, weight: .medium)
        label.textColor = UIColor.appColor(name: .textBlack)
        
        return label
    }()
    
    public lazy var switchButton: UISwitch = {
        let switchButton = UISwitch()
        switchButton.translatesAutoresizingMaskIntoConstraints = false
        //switchButton.thumbTintColor = UIColor.appColor(name: .switchButtonThumbColor)
        switchButton.tintColor = UIColor.appColor(name: .switchButtonOffTintColor)
        switchButton.onTintColor = UIColor.appColor(name: .switchButtonOnTintColor)
        switchButton.backgroundColor = UIColor.appColor(name: .switchButtonOffTintColor)
        switchButton.layer.cornerRadius = switchButton.frame.height / 2.0
        switchButton.clipsToBounds = true
        
        switchButton.addAction(UIAction {[weak self] _ in
            if let switchCallback = self?.switchCallback,
               var symptom = self?.symptom {
                symptom.disabled = !switchButton.isOn
                switchCallback(symptom)
            }
        }, for: .touchUpInside)
        
        return switchButton
    }()

    // MARK: - Initializer
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //Turn off default way of showing that row has been selected
        self.selectionStyle = .none
        self.showsReorderControl = true
        
        setupSubViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Setup SubViews
    private func setupSubViews() {
        [symptomLabel, switchButton].forEach({self.contentView.addSubview($0)})
    }
    
    // MARK: Setup constraints
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            symptomLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 15),
            symptomLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            symptomLabel.trailingAnchor.constraint(equalTo: self.contentView.centerXAnchor, constant: 95),
            switchButton.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -15),
            switchButton.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            symptomLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
        ])
    }
    
    public func configureCell(symptom: Symptom, switchCallback: @escaping (Symptom) -> Void ) {
        self.symptom = symptom
        symptomLabel.text = symptom.name
        switchButton.isOn = !symptom.disabled
        self.switchCallback = switchCallback
        
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        
        if(editing) {
            switchButton.isHidden = true
        } else {
            switchButton.isHidden = false
        }
    }
}
