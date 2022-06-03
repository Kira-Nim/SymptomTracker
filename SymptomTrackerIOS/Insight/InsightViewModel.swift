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
    }
    
    public func setView(view: InsightView, navbarView: NavBarDatePickerView) {
        self.view = view
        self.navbarView = navbarView
        setupGraphView(view.graphView)
        
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
            let graphDataDict = ChartDataFormattingService().generateChartDataVTOs(for: symptomRegistrations)
            
            // Greate array containing all the values from the "graphDataDict" dictionary (being LineChartDataSet)
            // Is used below to get a LineChartDataSet object that will be given to the LineChartView()
            let dataSetList = Array(graphDataDict.values)
            dataSetList.forEach { self.configureLineChartDataSet(dataSet: $0) }
            let data = LineChartData(dataSets: dataSetList)
            
            // Set attribute called data on the graphView (type: LineChartView())
            self.view?.graphView.data = data
            
            self.view?.graphView.setNeedsDisplay()
            
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
        graphView.xAxis.labelPosition = .bottom
        graphView.xAxis.centerAxisLabelsEnabled = true
        graphView.xAxis.drawGridLinesEnabled = false
    }
    
    private func configureLineChartDataSet(dataSet: LineChartDataSet) {
        dataSet.drawCirclesEnabled = false
        dataSet.drawValuesEnabled = false
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

extension InsightViewModel: UITableViewDelegate {
    
}

extension InsightViewModel: UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellReuseIdentifier", for: indexPath)

        cell.textLabel?.text = "Hello world"
    
        return cell
    }
}
