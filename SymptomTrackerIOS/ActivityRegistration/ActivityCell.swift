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
    public var activityLabel = UILabel()
    public var durationLabel = UILabel()
    
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
        activityLabel.textColor = activity?.strainColor
        activityLabel.text = activity?.name
        activityLabel.textAlignment = NSTextAlignment.left

        
        durationLabel.translatesAutoresizingMaskIntoConstraints = false
        durationLabel.numberOfLines = 0
        durationLabel.font = .appFont(ofSize: 17, weight: .medium)
        durationLabel.textColor = activity?.strainColor
        durationLabel.text = activity?.activityDurationString
        activityLabel.textAlignment = NSTextAlignment.left
    }
    
    // MARK: Setup subviews
    private func setupSubViews() {
        [activityLabel].forEach({ self.contentView.addSubview($0) })
    }
    
    // MARK: Setup constraints
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            activityLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 15),
            activityLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            activityLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            activityLabel.trailingAnchor.constraint(equalTo: durationLabel.leadingAnchor, constant: 10),
            
            durationLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: 15),
            durationLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            durationLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
        ])
        
    }
        
    // MARK: Confuguration for cell
    public func configureCell(activity: Activity) {
        self.activity = activity
    }
}
