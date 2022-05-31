//
//  ActivityViewModel.swift
//  SymptomTrackerIOS
//
//  Created by Kira Nim on 15/05/2022.
//

import Foundation
import UIKit

final class ActivityViewModel: NSObject {
    
    private var view: ActivityView? = nil
    public var modelManager: ModelManager
    private let cellReuseIdentifier =  "activityCell"
    public var showEditActivitySceneCallback: ((Activity) -> Void)?
    private let activityDurationService = ActivityDurationService()
    private let activityStrainPresenter = ActivityStrainService()
    private var selectedDate: Date
    private var selectedDateActivityList: [Activity] = []
    private var nextDateActivityList: [Activity] = []
    private var previousDateActivityList: [Activity] = []
    
    init(modelManager: ModelManager) {
        self.modelManager = modelManager
        self.selectedDate = Date()
        
        super.init()
        
        // It is ok to call this fynction here in stead of viewWillAppear because
        // the data on this page should not be changed due to changes made on other pages.
        // - Local update of data plus save to db is enough
        updateActivityLists()
        
    }
    
    // Function for updating activity lists (selected date + next and previous)
    private func updateActivityLists() {
        
        // update list containing registrations for selected date
        modelManager.getActivitiesForDate(date: selectedDate) { activityList in
            self.selectedDateActivityList = activityList
            self.updateView()
        }
        
        // If .date returns a non nil object for both metod calls get SymptomRegistration lists for previous and next date (compared to selected date)
        if let previousDate = Calendar.current.date(byAdding: .day, value: 1, to: selectedDate), let nextDate = Calendar.current.date(byAdding: .day, value: -1, to: selectedDate) {
            
            modelManager.getActivitiesForDate(date: nextDate) { activityList in
                self.nextDateActivityList = activityList
            }

            modelManager.getActivitiesForDate(date: previousDate) { activityList in
                self.previousDateActivityList = activityList
            }
        }
    }
    
    public func setView(view: ActivityView) {
        self.view = view
        
        view.activityTableView.delegate = self
        view.activityTableView.dataSource = self
        view.activityTableView.allowsSelectionDuringEditing = true
        
        // To make sure that a cell of type SymptomListCell is now available to the tableView.
        view.activityTableView.register(ActivityCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        self.view = view
        
        // set functionality to be executed when create new symptom confirmation button is tapped
        view.createActivityButtonView.addAction(UIAction { [weak self] _ in
            if let showEditActivitySceneCallback = self?.showEditActivitySceneCallback,
               let newActivity = self?.modelManager.createActivity(){
                    
                    // incert new activity into local activity list at index 0
                    self?.selectedDateActivityList.insert(newActivity, at: 0)
                
                    // Run callback to navigate back to symptom list page
                    showEditActivitySceneCallback(newActivity)
            }
        }, for: .touchUpInside)
    }
    
    // When OS calles setEditing() on ActivityViewController, the controller will call this method.
    public func setEditing(_ state: Bool, animated: Bool) {
        view?.activityTableView.setEditing(state, animated: animated)
        
        if let view = view {
            if state {
                view.buttonContentViewConstraint?.constant = 75
                view.createActivityButtonViewConstraint?.constant = 38
            } else {
                view.buttonContentViewConstraint?.constant = 0
                view.createActivityButtonViewConstraint?.constant = 0
            }
        }
    }
    
    public func updateView() {
        view?.activityTableView.reloadData()
    }
}

extension ActivityViewModel: UITableViewDelegate {
    
    // Method for when a row is selected by user.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Only navigate to change the activity name page if the activity name is selected in editing mode
        // tableView refers to self.view
        if tableView.isEditing {
            showEditActivitySceneCallback?(selectedDateActivityList[indexPath.row])
        }
    }
    
    // Method for setting editing style on cell.
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
}

extension ActivityViewModel: UITableViewDataSource {
    
    // How many sections
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // How many rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedDateActivityList.count
    }
    
    // Method for configuring row height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    // Choose cell type for each row and configure it.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath)
        if let activityCell = cell as? ActivityCell {
            activityCell.configureCell(activity: selectedDateActivityList[indexPath.row], presentDurationCallback: activityDurationService.getDurationStringForMinutes, presentActivityStrainColorCallback: activityStrainPresenter.getActivityColorForStrain)
        }
        return cell
    }
    
    // For when user chooses to delete a activity from activitylist in editing state
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        // Delete activity frem db
        let activityToDelete = selectedDateActivityList[indexPath.row]
        modelManager.delete(activity: activityToDelete)
        
        //Remove activity from local list
        selectedDateActivityList.remove(at: indexPath.row)
        
        // Update view
        // The tableView taken as param above (and used here) refers to self.view.
        tableView.deleteRows(at: [indexPath], with: .fade)
    }
}
    
