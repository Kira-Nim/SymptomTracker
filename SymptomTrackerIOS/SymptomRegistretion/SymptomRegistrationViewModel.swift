//
//  SymptomRegistrationViewModel.swift
//  SymptomTrackerIOS
//
//  Created by Kira Nim on 15/05/2022.
//

import Foundation
import UIKit

final class SymptomRegistrationViewModel: NSObject {
    public var modelManager: ModelManager
    private var view: SymptomRegistrationView?
    private var navbarView: NavBarDatePickerView?
    private let cellReuseIdentifier =  "cellReuseIdentifier"
    private var selectedDateRegistrations: [SymptomRegistration] = []
    private var currentDate: Date
    
    // A presenter service for making the symptom-intensities presentable (colors)
    private let symptomIntensityService = SymptomIntensityService()
    
    // MARK: Init
    init(modelManager: ModelManager) {
        self.modelManager = modelManager
        self.currentDate = Date()
        super.init()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updateSymptomRegistrationList),
                                               name: modelManager.symptomsUpdatedNotificationName,
                                               object: nil)
    }
    
    // MARK: setView()
    
    public func setView(view: SymptomRegistrationView, navbarView: NavBarDatePickerView) {
        self.view = view
        self.navbarView = navbarView
        view.registrationTableView.delegate = self
        view.registrationTableView.dataSource = self
        
        // To make sure that a cell of type SymptomRegistrationCell is now available to the tableView.
        view.registrationTableView.register(SymptomRegistrationCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        
        let changeDateCallback = { date in
            self.changeToSelectedDate(chosenDate: date)
        }
        let getDateStringCallback: (Date) -> String = { date in
            let dateConverterService = DateConverterService()
            let dateString = dateConverterService.convertDateFrom(date: date)
            return dateString
        }
        
        self.view = view
        navbarView.configureView(date: currentDate, changeDateCallback: changeDateCallback, getDateStringCallback: getDateStringCallback)
    }
    
    // MARK: updateView()
    public func updateView() {
        view?.registrationTableView.reloadData()
    }
    
    // MARK: viewWillAppear
    public func viewWillAppear() {
        
        // called here because the symptomRegistrationView's data should be updated when changes
        // are made on other pages in the app
        updateSymptomRegistrationList()
    }
    
    // MARK: Help functions
    @objc
    public func updateSymptomRegistrationList() {
        // update list containing registrations for selected date
        modelManager.getRegistrationsForDate(date: currentDate) { symptomRegistrations in
            self.selectedDateRegistrations = symptomRegistrations
            self.updateView()
        }
    }
    
    public func changeToSelectedDate(chosenDate: Date) {
        currentDate = chosenDate
        updateSymptomRegistrationList()
    }
}

// MARK: Extention: UITableViewDelegate
extension SymptomRegistrationViewModel: UITableViewDelegate {
}

// MARK: Extention: UITableViewDataSource
extension SymptomRegistrationViewModel: UITableViewDataSource {
    
    // How many sections
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // How many rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedDateRegistrations.count
    }
    
    // Method responsible for declaring which cell type should be used for each row and for configuring that cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath)
        
        if let symptomRegistrationCell = cell as?  SymptomRegistrationCell {
            symptomRegistrationCell.configureCell(symptomRegistration: selectedDateRegistrations[indexPath.row],
                                                  presentRegistrationIntensityCallback: symptomIntensityService.getIntensityColorForRegistration) { symptomRegistration in
                self.modelManager.updateRegistration(symptomRegistration: symptomRegistration)
            }
        }
        return cell
    }
    
    // Method for configuring row height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 83
    }
}
