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
        activityLabel.textColor = UIColor.appColor(name: .textBlack)
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
            activityLabel.trailingAnchor.constraint(equalTo: self.contentView.centerXAnchor, constant: 95),
        ])
        
    }
        
    // MARK: Confuguration for cell
    public func configureCell(activity: Activity) {
        self.activity = activity
        activityLabel.text = activity.name
    }
}
