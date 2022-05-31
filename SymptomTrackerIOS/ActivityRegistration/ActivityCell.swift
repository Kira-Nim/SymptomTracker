//
//  ActivityCell.swift
//  SymptomTrackerIOS
//
//  Created by Kira Nim on 30/05/2022.
//

import Foundation
import UIKit

class ActivityCell: UITableViewCell {
    private var activity: Activity?
    
    // MARK: Subviews
    private var activityLabel = UILabel()
    private var durationLabel = UILabel()
    private var presentActivityStrainColorCallback: ((Int) -> UIColor)?
    private var presentDurationCallback: ((Int) -> String)?
    
    // MARK: - Initializer
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //Turn off default way of showing that row has been selected
        self.selectionStyle = .none
        self.showsReorderControl = true
        
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
    func setAttributesOnSubViews() {
        activityLabel.translatesAutoresizingMaskIntoConstraints = false
        activityLabel.numberOfLines = 0
        activityLabel.font = .appFont(ofSize: 17, weight: .medium)
        activityLabel.text = activity?.name
        activityLabel.textAlignment = NSTextAlignment.left
        if let activityColor = activity?.strain {
            let strainUIColor = presentActivityStrainColorCallback?(activityColor)
            activityLabel.textColor = strainUIColor
        }

        durationLabel.translatesAutoresizingMaskIntoConstraints = false
        durationLabel.numberOfLines = 0
        durationLabel.font = .appFont(ofSize: 17, weight: .medium)
        durationLabel.textAlignment = NSTextAlignment.left
        
        // Set textColor of activity based on choosen strain level. If strain level is 0 then the text should be black
        // else the textcolor should reflect the color shown in the select strain view chen creating an activity
        if let strain = activity?.strain {
            var strainUIColor = UIColor.appColor(name: .textBlack)
            if(strain != 0) {
                if let colorForText = presentActivityStrainColorCallback?(strain) {
                    strainUIColor = colorForText}
            }
            durationLabel.textColor = strainUIColor
        }
        
        durationLabel.textAlignment = NSTextAlignment.left
        if let duration = activity?.numMinutes {
            durationLabel.text = presentDurationCallback?(duration)
        }
    }

    // MARK: Setup subviews
    private func setupSubViews() {
        [activityLabel, durationLabel].forEach({ self.contentView.addSubview($0) })
    }
    
    // MARK: Setup constraints
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            activityLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            activityLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            activityLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            activityLabel.trailingAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 10),
            
            durationLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -15),
            durationLabel.leadingAnchor.constraint(equalTo: activityLabel.trailingAnchor, constant: 25),
            durationLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            durationLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
        ])
        
    }
        
    // MARK: Confuguration for cell
    public func configureCell(activity: Activity, presentDurationCallback: @escaping ((Int) -> String), presentActivityStrainColorCallback: @escaping ((Int) -> UIColor)) {
        self.activity = activity
        self.presentDurationCallback = presentDurationCallback
        self.presentActivityStrainColorCallback = presentActivityStrainColorCallback
        self.presentDurationCallback = presentDurationCallback
        self.setAttributesOnSubViews()
    }
}
