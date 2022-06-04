//
//  InsightViewModel.swift
//  SymptomTrackerIOS
//
//  Created by Kira Nim on 15/05/2022.
//

import Foundation
import UIKit
import Charts

final class InsightViewModel: NSObject {
    
    public var presentSelectFromSymptomListController: (() -> Void)?
    private var view: InsightView?
    private var navbarView: NavBarDatePickerView?
    public var modelManager: ModelManager
    public var navigationBarButtonItem = UIBarButtonItem()
    private var currentDate: Date
    private var startDate: Date
    private var endDate: Date
    private var selectedCalendarIntervalType: CalendarIntervalType = .month
    private let intervalService = CalendarDateIntervalService()
    private let weekDateFormatter = DateFormatter()
    private let monthDateFormatter = DateFormatter()
    private let dataFormattingService = ChartDataFormattingService()
    private let activityStrainService = ActivityStrainService()
    
    // Colors for graph
    private let symptomGraphLineColors = [UIColor.appColor(name: .graphLineColor01),
                                          UIColor.appColor(name: .graphLineColor02),
                                          UIColor.appColor(name: .graphLineColor03),
                                          UIColor.appColor(name: .graphLineColor04),
                                          UIColor.appColor(name: .graphLineColor05),
                                          UIColor.appColor(name: .graphLineColor06),
                                          UIColor.appColor(name: .graphLineColor07),
                                          UIColor.appColor(name: .graphLineColor08),
                                          UIColor.appColor(name: .graphLineColor09),
                                          UIColor.appColor(name: .graphLineColor10),
                                          UIColor.appColor(name: .graphLineColor11),
                                          UIColor.appColor(name: .graphLineColor12),
                                          UIColor.appColor(name: .graphLineColor13),
                                          UIColor.appColor(name: .graphLineColor14),
                                          UIColor.appColor(name: .graphLineColor15),
                                          UIColor.appColor(name: .graphLineColor15),
                                          UIColor.appColor(name: .graphLineColor16),
                                          UIColor.appColor(name: .graphLineColor17),
                                          UIColor.appColor(name: .graphLineColor18),
                                          UIColor.appColor(name: .graphLineColor19),
                                          UIColor.appColor(name: .graphLineColor20),
                                          UIColor.appColor(name: .graphLineColor21),
                                          UIColor.appColor(name: .graphLineColor22),
                                          UIColor.appColor(name: .graphLineColor22) ]
    
    init(modelManager: ModelManager) {
        self.modelManager = modelManager
        self.currentDate = Date()
        let (startDate, endDate) = intervalService.startAndEndDateOfIntervalFor(date: self.currentDate, intervalType: selectedCalendarIntervalType)
        self.startDate = startDate
        self.endDate = endDate
        super.init()
        self.navigationBarButtonItem = UIBarButtonItem(title: LocalizedStrings.shared.insightNavigationItemText, image: nil, primaryAction: UIAction {[weak self] _ in
            self?.presentSelectFromSymptomListController?()
        }, menu: nil)
        self.weekDateFormatter.dateFormat = "EEE d"
        self.monthDateFormatter.dateFormat = "d"
    }
    
    public func setView(view: InsightView, navbarView: NavBarDatePickerView) {
        self.view = view
        self.navbarView = navbarView
        setupGraphView(view.graphView)
        setupPieChartView(view.pieChart)
        
        // For the date picker shown in the navbar
        let getDateStringCallback: (Date) -> String = { date in
            let dateConverterService = DateConverterService()
            let dateString = dateConverterService.convertDateFrom(date: date)
            return dateString
        }
        let changeDateCallback: (Date) -> Void = { chosenDate in
            self.currentDate = chosenDate
            self.updateView()
        }
        navbarView.configureView(date: currentDate, changeDateCallback: changeDateCallback, getDateStringCallback: getDateStringCallback)
        
        // For segmented control view
        view.segmentedControlView.addTarget(self, action: #selector(segmentChanged), for: .valueChanged)
        view.segmentedControlView.selectedSegmentIndex = selectedCalendarIntervalType.rawValue
    }
    
    public func viewWillAppear() {
        fetchData()
    }
    
    /* Method for fetching Value transfer objects carriing symptom registration data for the graph view
       The VTO's are dictionaries of key = Int (placementOrder value on symptoms), value: LineChartDataSet (type in grapg dependency)
       LineChartDataSet is an object containing an array of chartDataEntry objects.
       ChartDataEntry are also objects in the Charts library. They each represent a data point in the graph. They have a x and y attribute.
     */
    private func fetchData() {
            
        /* getRegistrationsForInterval is called on modelManager.
           A function os passed as argument, This callback function will be passed on by the modelManager
           in yet another callback to the symptomRegistrationRepository where the callback chail will be started
           when/if the data is succesfulle fetched.
         */
        modelManager.getRegistrationsForInterval(startDate: startDate, endDate: endDate) { symptomRegistrations in
            let graphDataDict = self.dataFormattingService.generateChartDataVTOs(for: symptomRegistrations)
            
            // Create array containing all the values from the "graphDataDict" dictionary (being LineChartDataSet)
            // Is used below to get a LineChartDataSet object that will be given to the LineChartView()
            
            self.configureLineChartDataSets(dataSetsDict: graphDataDict)
            let dataSetList = graphDataDict.map { k, v in (k, v) }.sorted { $0.0 < $1.0 }.map { $1 }
            //let dataSetList = Array(graphDataDict.values)
            let data = LineChartData(dataSets: dataSetList)
            
            // Set attribute called data on the graphView (type: LineChartView())
            self.view?.graphView.data = data
            self.updateGraphView()
        }
        
        modelManager.getActivitiesForInterval(startDate: startDate, endDate: endDate) { activities in
            let dataSet = self.dataFormattingService.generatePieChartDataVTOs(activities: activities)
            self.configurePieChartDataSet(dataSet: dataSet)
            let data = PieChartData(dataSet: dataSet)
            self.view?.pieChart.data = data
            self.view?.pieChart.notifyDataSetChanged()
        }
    }
    
    private func updateView() {
        let (startDate, endDate) = intervalService.startAndEndDateOfIntervalFor(date: self.currentDate, intervalType: selectedCalendarIntervalType)
        self.startDate = startDate
        self.endDate = endDate
        fetchData()
    }
    
    private func setupGraphView(_ graphView: LineChartView) {
        graphView.backgroundColor = .white
        graphView.rightAxis.enabled = false
        graphView.leftAxis.granularity = 1.0
        graphView.leftAxis.drawGridLinesEnabled = false
        graphView.leftAxis.axisMinimum = 0.0
        graphView.leftAxis.axisMaximum = 4.0
        graphView.xAxis.labelPosition = .bottom
        graphView.xAxis.centerAxisLabelsEnabled = true
        //graphView.xAxis.drawGridLinesEnabled = false
        graphView.xAxis.valueFormatter = self
        graphView.xAxis.granularity = 24.0 * 60.0 * 60.0 // a full day in seconds
        graphView.xAxis.granularityEnabled = true
        graphView.pinchZoomEnabled = false
        graphView.dragEnabled = false
        graphView.highlightPerTapEnabled = false
        graphView.highlightPerDragEnabled = false
    }
    
    private func setupPieChartView(_ pieChartView: PieChartView) {
        pieChartView.backgroundColor = .white
        pieChartView.drawEntryLabelsEnabled = false
        pieChartView.rotationEnabled = false
    }
    
    private func updateGraphView() {
        let startOfStartDate = Calendar.current.startOfDay(for: self.startDate)
        let dayAfterEndDate = Calendar.current.date(byAdding: .day, value: 1, to: endDate) ?? endDate
        let startOfDayAfterEndDate = Calendar.current.startOfDay(for: dayAfterEndDate)
        
        self.view?.graphView.xAxis.axisMinimum = startOfStartDate.timeIntervalSince1970
        self.view?.graphView.xAxis.axisMaximum = startOfDayAfterEndDate.timeIntervalSince1970
        self.view?.graphView.xAxis.setLabelCount(8, force: true)
        self.view?.graphView.notifyDataSetChanged()
    }
    
    private func configureLineChartDataSets(dataSetsDict: [Int: LineChartDataSet]) {
        dataSetsDict.forEach { symptomPlacement, dataSet in
            dataSet.drawCirclesEnabled = false
            dataSet.drawValuesEnabled = false
            let index = symptomPlacement % symptomGraphLineColors.count
            dataSet.colors = [symptomGraphLineColors[index]]
        }
    }
    
    private func configurePieChartDataSet(dataSet: PieChartDataSet) {
        dataSet.resetColors()
        dataSet.colors = [
            activityStrainService.getActivityColorForStrain(0),
            activityStrainService.getActivityColorForStrain(1),
            activityStrainService.getActivityColorForStrain(2),
            activityStrainService.getActivityColorForStrain(3)
        ]
    }
    
    public func willTransitionTo(landscape: Bool) {
        
        if landscape {
            view?.setRotation(to: true)
        } else {
            view?.setRotation(to: false)
        }
    }
    
    // Callback for when a strain option is selected when creating or editing activity
    @objc
    private func segmentChanged() {
        guard let segmentedControlView = view?.segmentedControlView else { return }
                
        let value = segmentedControlView.selectedSegmentIndex
        // cast int to enum and assign the selectedCalendarIntervalType attribute, then update the view with the new settings
        if let newIntervalValue = CalendarIntervalType(rawValue: value) {
            selectedCalendarIntervalType = newIntervalValue
            updateView()
        }
    }
}

extension InsightViewModel: AxisValueFormatter {
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        
        let date = Date(timeIntervalSince1970: value)
        //print(date)
        var dateFormatter = weekDateFormatter
        switch selectedCalendarIntervalType {
        case .week:
            dateFormatter = weekDateFormatter
        case .month:
            dateFormatter = monthDateFormatter
        default:
            dateFormatter = weekDateFormatter
        }
        return dateFormatter.string(from: date)
    }
}
