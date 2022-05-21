//
//  SymptomListCell.swift
//  SymptomTrackerIOS
//
//  Created by Kira Nim on 21/05/2022.
//

import Foundation
import UIKit

class SymptomListCell: UITableViewCell {
    
    private var symptomName: String = "Kognitive vanskeligheder med sy e"
    
    //MARK: Subviews
    public lazy var symptomLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = symptomName
        label.numberOfLines = 0
        
        return label
    }()
    
    public lazy var switchButton: UISwitch = {
        let switchButton = UISwitch()
        switchButton.translatesAutoresizingMaskIntoConstraints = false
        
        switchButton.onTintColor = UIColor.orange
        switchButton.thumbTintColor = UIColor.purple
        switchButton.tintColor = UIColor.green
        //switchButton.thumbTintColor = UIColor.yellow
        //switchButton.onTintColor = UIColor(red: 45/255, green: 45/255, blue: 45/255, alpha: 0.4)
        switchButton.layer.cornerRadius = switchButton.frame.height / 2.0
        switchButton.backgroundColor = UIColor.green
        switchButton.clipsToBounds = true
        
        return switchButton
    }()

    // MARK: - Initializer
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //Turn off default way of showing that row has been selected
        self.selectionStyle = .none
        
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
            //symptomLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            //symptomLabel.widthAnchor.constraint(equalTo: self.contentView.widthAnchor),
            symptomLabel.trailingAnchor.constraint(equalTo: self.contentView.centerXAnchor, constant: 90),
            
            switchButton.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -15),
            switchButton.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            symptomLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
        ])
    }
}
