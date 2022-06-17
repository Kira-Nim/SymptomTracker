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
    
    // Callback for presenting symptomList site to user
    public var presentSelectFromSymptomListController: (() -> Void)?
    
    private var view: InsightView?
    private var navbarView: NavBarDatePickerView?
    public var modelManager: ModelManager
    public var navigationBarButtonItem = UIBarButtonItem()
    private var currentDate: Date
    private var startDate: Date
    private var endDate: Date
    private var selectedCalendarIntervalType: CalendarIntervalType = .month
    
    // Service to deliver start and end date of an interval around a given date.
    private let intervalService = CalendarDateIntervalService()
    
    private let weekDateFormatter = DateFormatter()
    private let monthDateFormatter = DateFormatter()
    
    // Service for converting data to something that can be used with Charts
    private let dataFormattingService = ChartDataFormattingService()
    
    // Service for getting the right color for a strain option of an activity
    private let activityStrainService = ActivityStrainService()
    
    // This is implemented as a bugfix becase I couldn't get the graph-x-axis to show a month properly
    private var customAxisRenderer: MonthAxisRenderer?
    
    // Colors for graph lines
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
    
    // MARK: init
    
    init(modelManager: ModelManager) {
        self.modelManager = modelManager
        
        // Date of today
        self.currentDate = Date()
        
        // Tuple with start and end date of interval within which current date lies
        let (startDate, endDate) = intervalService.startAndEndDateOfIntervalFor(date: self.currentDate, intervalType: selectedCalendarIntervalType)
        self.startDate = startDate
        self.endDate = endDate
        super.init()
        
        // Set action on bar button. action is running a navigation callback resulting in showing symptomlist without edit options mode available.
        self.navigationBarButtonItem = UIBarButtonItem(title: LocalizedStrings.shared.insightNavigationItemText, image: nil, primaryAction: UIAction {[weak self] _ in
            self?.presentSelectFromSymptomListController?()
        }, menu: nil)
        
        // Formatters for dates shown on graph
        self.weekDateFormatter.dateFormat = "EEE d"
        self.monthDateFormatter.dateFormat = "d"
    }
    
    // MARK: setView()
    public func setView(view: InsightView, navbarView: NavBarDatePickerView) {
        self.view = view
        self.navbarView = navbarView
        setupGraphView(view.graphView)
        setupPieChartView(view.pieChart)
        
        // Setup of the date picker shown in the navbar
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
        
        // setup for segmented control view (selecting to view timeintervals as weeks or month on graph)
        view.segmentedControlView.addTarget(self, action: #selector(segmentChanged), for: .valueChanged)
        view.segmentedControlView.selectedSegmentIndex = selectedCalendarIntervalType.rawValue
    }
    
    // MARK: viewWillAppear()
    public func viewWillAppear() {
        fetchData()
    }
    
    // MARK: HelpFunction
    
    /* Method for fetching Value transfer objects carrying symptom registration data for the graph view and showing it
       The VTO's are dictionaries of key = Int (placementOrder value on symptoms), value: LineChartDataSet (type in grapg dependency)
       LineChartDataSet is an object containing an array of chartDataEntry objects.
       ChartDataEntry are also objects in the Charts library. They each represent a data point in the graph. They have a x and y attribute.
     */
    private func fetchData() {
            
        /* getRegistrationsForInterval is called on modelManager.
           A callback is passed as argument. This callback will be passed on by the modelManager
           in yet another callback to the symptomRegistrationRepository where the callback chain will be executed when/if the data is succesfulle fetched.
         */
        modelManager.getRegistrationsForInterval(startDate: startDate, endDate: endDate) { symptomRegistrations in
            
            let graphDataDict = self.dataFormattingService.generateChartDataVTOs(for: symptomRegistrations)
            
            // Create array containing all the values from the "graphDataDict" dictionary (being LineChartDataSet)
            // Is used below to get a LineChartDataSet object that will be given to the LineChartView()
            
            // Set styling configuration for graph
            self.configureLineChartDataSets(dataSetsDict: graphDataDict)
            
            // step 1) map from dict to list of tuples 2) sort tuple list based on key from dict 3) make new list of all the values from dict (these being LineChartDataSet's)
            let dataSetList = graphDataDict.map { k, v in (k, v) }.sorted { $0.0 < $1.0 }.map { $1 }
            
            // Create a LineChartData instance to wrap the list of LineChartDataSets.
            // This will be a wrapper containing a list of wrappers that each contain a list of ChartdataEntry's
            let data = LineChartData(dataSets: dataSetList)
            
            // Set attribute called data on the graphView - Deliver data to be shown on chart and let go :)
            self.view?.graphView.data = data
            data.setValueTextColor(UIColor.appColor(name: .textBlack))
            
            // "reload" the graph to show data update.
            self.updateGraphView()
        }
        
        // Method for fetching data for the pie chart and showing it
        modelManager.getActivitiesForInterval(startDate: startDate, endDate: endDate) { [self] activities in
            let dataSet = self.dataFormattingService.generatePieChartDataVTOs(activities: activities, startDate: startDate, endDate: self.endDate)
            self.configurePieChartDataSet(dataSet: dataSet)
            let data = PieChartData(dataSet: dataSet)
            
            data.setValueTextColor(UIColor.appColor(name: .textBlack))
            self.view?.pieChart.data = data
            
            // There is a bug in the charts library that requires this to be set after data has been assigned to the chart. It is for costumizing how many decimals we want shown.
            // See https://github.com/danielgindi/Charts/issues/4690
            data.setValueFormatter(DefaultValueFormatter(decimals: 1))
            self.view?.pieChart.notifyDataSetChanged()
        }
    }
    
    // MARK: updateView()
    
    private func updateView() {
        // Set dates for interval on graph based on currently selected date
        let (startDate, endDate) = intervalService.startAndEndDateOfIntervalFor(date: self.currentDate, intervalType: selectedCalendarIntervalType)
        self.startDate = startDate
        self.endDate = endDate
        
        // fetch Value transfer objects carrying symptom registration data for the graph view (for the dates above)
        fetchData()
    }
    
    // MARK: setupGraphView()
    private func setupGraphView(_ graphView: LineChartView) {
        graphView.rightAxis.enabled = false // only an y-axis in the left side
        graphView.leftAxis.granularity = 1.0 // granulary of the space between sections on y-axis
        graphView.leftAxis.drawGridLinesEnabled = false // no horizontal lines from the y-axis and out
        graphView.leftAxis.axisMinimum = 0.0
        graphView.leftAxis.axisMaximum = 4.0 // because this is max intensity
        graphView.xAxis.labelPosition = .bottom
        graphView.xAxis.valueFormatter = self // refers to extention in the borrom of class (extension)
        
        let customAxisRenderer = MonthAxisRenderer(viewPortHandler: graphView.xAxisRenderer.viewPortHandler,
                                                   axis: graphView.xAxisRenderer.axis,
                                                   transformer: graphView.xAxisRenderer.transformer)
        self.customAxisRenderer = customAxisRenderer // Costum implementation because of trouble with x-axix.
        graphView.xAxisRenderer = customAxisRenderer
        
        graphView.pinchZoomEnabled = false
        graphView.dragEnabled = false
        graphView.highlightPerTapEnabled = false
        graphView.highlightPerDragEnabled = false
        graphView.extraBottomOffset = 5 // More distance between graph and legend
        graphView.legend.textColor = UIColor.appColor(name: .textBlack)
    }
    
    // MARK: setupPieChartView()
    private func setupPieChartView(_ pieChartView: PieChartView) {
        pieChartView.backgroundColor = .white
        pieChartView.drawEntryLabelsEnabled = false // dont write strain type name in the piechart (not enough room)
        pieChartView.rotationEnabled = false // drag and rotate functionality off
        pieChartView.centerText = LocalizedStrings.shared.tabbarActivityText // What is in the middle of pie
        pieChartView.minOffset = 0.0 // Distance between slices.
        let attribute = [NSAttributedString.Key.foregroundColor: UIColor.appColor(name: .textBlack)]
        let attributedString = NSAttributedString(string: LocalizedStrings.shared.tabbarActivityText, attributes: attribute)
        pieChartView.centerAttributedText = attributedString // set color of text in the middle of chart
    }
    
    // MARK: updateGraphView()
    private func updateGraphView() {
        let startOfStartDate = Calendar.current.startOfDay(for: self.startDate)
        let dayAfterEndDate = Calendar.current.date(byAdding: .day, value: 1, to: endDate) ?? endDate
        let startOfDayAfterEndDate = Calendar.current.startOfDay(for: dayAfterEndDate)
        
        self.view?.graphView.xAxis.axisMinimum = startOfStartDate.timeIntervalSince1970
        self.view?.graphView.xAxis.axisMaximum = startOfDayAfterEndDate.timeIntervalSince1970
        
        if selectedCalendarIntervalType == .week {
            self.view?.graphView.xAxis.centerAxisLabelsEnabled = true
            self.view?.graphView.xAxis.granularity = 24.0 * 60.0 * 60.0 // a full day in seconds
            self.view?.graphView.xAxis.granularityEnabled = true
            self.view?.graphView.xAxis.setLabelCount(8, force: true)
            customAxisRenderer?.overrideWithWeekInterval = false
        } else {
            self.view?.graphView.xAxis.centerAxisLabelsEnabled = true
            customAxisRenderer?.overrideWithWeekInterval = true
        }
        
        self.view?.graphView.notifyDataSetChanged()
    }
    
    // MARK: help functions
    private func configureLineChartDataSets(dataSetsDict: [Int: LineChartDataSet]) {
        dataSetsDict.forEach { symptomPlacement, dataSet in
            dataSet.drawCirclesEnabled = false // dont make cirkel around each point on graph
            dataSet.drawValuesEnabled = false // dont show the value of a point on graph
            let index = symptomPlacement % symptomGraphLineColors.count // modulo to avoid index out of bounds
            dataSet.colors = [symptomGraphLineColors[index]]
        }
    }
    
    // Set colors for each pie piece
    private func configurePieChartDataSet(dataSet: PieChartDataSet) {
        dataSet.resetColors()
        dataSet.colors = [
            activityStrainService.getActivityColorForStrain(0),
            activityStrainService.getActivityColorForStrain(1),
            activityStrainService.getActivityColorForStrain(2),
            activityStrainService.getActivityColorForStrain(3)
        ]
        dataSet.selectionShift = 0.0
    }
    
    public func willTransitionTo(landscape: Bool) {
        
        if landscape {
            view?.setRotation(to: true)
        } else {
            view?.setRotation(to: false)
        }
    }
    
    // Callback for when changing between week or month in segmented control.
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

// MARK: extension - AxisValueFormatter
extension InsightViewModel: AxisValueFormatter {

    // For formatting of labels on x-axis
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        
        let date = Date(timeIntervalSince1970: value)
        switch selectedCalendarIntervalType {
        case .week:
            return weekDateFormatter.string(from: date)
        case .month:
            let weekNumber = Calendar.current.component(.weekOfYear, from: date)
            return "Uge \(weekNumber)"
        default:
            return ""
        }
    }
}
