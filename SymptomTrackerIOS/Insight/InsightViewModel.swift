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
    private var view: InsightView? = nil
    public var modelManager: ModelManager
    public var navigationBarButtonItem = UIBarButtonItem()
    private var startDate: Date
    private var endDate: Date
    
    init(modelManager: ModelManager) {
        self.modelManager = modelManager
        self.startDate = Date()
        self.endDate = Date()
        super.init()
        self.endDate = Calendar.current.date(byAdding: .day, value: 6, to: startDate) ?? startDate
        self.navigationBarButtonItem = UIBarButtonItem(title: LocalizedStrings.shared.insightNavigationItemText, image: nil, primaryAction: UIAction {[weak self] _ in
            self?.presentSelectFromSymptomListController?()
        }, menu: nil)
    }
    
    public func setView(view: InsightView) {
        self.view = view
        setupGraphView(view.graphView)
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
            self.updateView()
            
            self.view?.graphView.setNeedsDisplay()
            
        }
    }
    
    private func updateView() {
        
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
