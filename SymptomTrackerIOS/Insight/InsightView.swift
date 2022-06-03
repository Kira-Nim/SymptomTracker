//
//  InsightView.swift
//  SymptomTrackerIOS
//
//  Created by Kira Nim on 15/05/2022.
//

import Foundation
import UIKit
import Charts

class InsightView: UIView {
    
    // MARK: Subviews
    public let graphOuterContentView = UIView()
    public let graphInnerContentView = UIView()
    public let graphView = LineChartView()
    public let changeOrientationImage = UIImageView()
    public let pieChartContentView = UIView()
    public let pieChart = UIView()
    public let segmentedControlContentView = UIView()
    public let segmentedControlView = UISegmentedControl(items: ["Uge", "Måned"])
    
    
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
        segmentedControlView.selectedSegmentTintColor = UIColor.appColor(name: .graphSegmentedControlColor)
        
        graphOuterContentView.translatesAutoresizingMaskIntoConstraints = false
        graphOuterContentView.backgroundColor = UIColor.lightGray
        graphOuterContentView.layer.cornerRadius = 4
        graphOuterContentView.layer.borderWidth = 0.5
        
        graphInnerContentView.translatesAutoresizingMaskIntoConstraints = false
        graphInnerContentView.backgroundColor = UIColor.green
        graphInnerContentView.layer.cornerRadius = 4
        graphInnerContentView.layer.borderWidth = 0.5
        
        graphView.translatesAutoresizingMaskIntoConstraints = false
 
        
        changeOrientationImage.translatesAutoresizingMaskIntoConstraints = false
        changeOrientationImage.backgroundColor = UIColor.black
        
        pieChartContentView.translatesAutoresizingMaskIntoConstraints = false
        pieChartContentView.backgroundColor = UIColor.darkGray
        pieChartContentView.layer.cornerRadius = 4
        pieChartContentView.layer.borderWidth = 0.5
        
        pieChart.translatesAutoresizingMaskIntoConstraints = false
        pieChart.backgroundColor = UIColor.white
        pieChart.layer.cornerRadius = 4
        pieChart.layer.borderWidth = 0.5
        
        segmentedControlContentView.translatesAutoresizingMaskIntoConstraints = false
        segmentedControlContentView.backgroundColor = UIColor.blue
        segmentedControlContentView.layer.cornerRadius = 4
        segmentedControlContentView.layer.borderWidth = 0.5
        
        segmentedControlView.translatesAutoresizingMaskIntoConstraints = false
        segmentedControlView.backgroundColor = UIColor.white
        segmentedControlView.layer.cornerRadius = 4
        segmentedControlView.layer.borderWidth = 0.5
    }
    
    // MARK: Setup subviews
    private func setupSubViews() {
        segmentedControlContentView.addSubview(segmentedControlView)
        pieChartContentView.addSubview(pieChart)
        [graphView, changeOrientationImage].forEach({graphInnerContentView.addSubview($0)})
        [graphInnerContentView, segmentedControlContentView].forEach({graphOuterContentView.addSubview($0)})
        [graphOuterContentView, pieChartContentView].forEach({self.addSubview($0)})
    }
    
    // MARK: Setup constraints
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            graphOuterContentView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            graphOuterContentView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 33),
            graphOuterContentView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -33),
            graphOuterContentView.bottomAnchor.constraint(equalTo: self.centerYAnchor, constant: 70),
        
            segmentedControlContentView.topAnchor.constraint(equalTo: graphOuterContentView.topAnchor, constant: 40),
            segmentedControlContentView.leadingAnchor.constraint(equalTo: graphOuterContentView.leadingAnchor),
            segmentedControlContentView.trailingAnchor.constraint(equalTo: graphOuterContentView.trailingAnchor),
            segmentedControlContentView.heightAnchor.constraint(equalToConstant: 50),
            segmentedControlContentView.bottomAnchor.constraint(equalTo: graphInnerContentView.topAnchor),
            
            graphInnerContentView.bottomAnchor.constraint(equalTo: graphOuterContentView.bottomAnchor),
            graphInnerContentView.leadingAnchor.constraint(equalTo: graphOuterContentView.leadingAnchor),
            graphInnerContentView.trailingAnchor.constraint(equalTo: graphOuterContentView.trailingAnchor),
            graphInnerContentView.topAnchor.constraint(equalTo: segmentedControlContentView.bottomAnchor, constant: 40),

            changeOrientationImage.topAnchor.constraint(equalTo: graphInnerContentView.topAnchor, constant: 4),
            changeOrientationImage.trailingAnchor.constraint(equalTo: graphInnerContentView.trailingAnchor),
            changeOrientationImage.bottomAnchor.constraint(greaterThanOrEqualTo: graphView.topAnchor, constant: -4),
            changeOrientationImage.heightAnchor.constraint(equalToConstant: 33),
            changeOrientationImage.widthAnchor.constraint(equalToConstant: 33),
             
            graphView.leadingAnchor.constraint(equalTo: graphInnerContentView.leadingAnchor),
            graphView.trailingAnchor.constraint(equalTo: graphInnerContentView.trailingAnchor),
            graphView.bottomAnchor.constraint(equalTo: graphInnerContentView.bottomAnchor),
            
            pieChart.centerYAnchor.constraint(equalTo: pieChartContentView.centerYAnchor),
            pieChart.centerXAnchor.constraint(equalTo: pieChartContentView.centerXAnchor),
            pieChart.heightAnchor.constraint(equalToConstant: 175),
            pieChart.widthAnchor.constraint(equalToConstant: 175),
             
            pieChartContentView.topAnchor.constraint(equalTo: graphOuterContentView.bottomAnchor),
            pieChartContentView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            pieChartContentView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 33),
            pieChartContentView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -33),
        ])
    }
}
