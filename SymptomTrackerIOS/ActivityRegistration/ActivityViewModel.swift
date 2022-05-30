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
    private let cellReuseIdentifier =  "cell"
    private var activityList: [Activity] = []
    public var changeNameCallback: ((Activity) -> Void)?
    private let activityDurationPresenter = ActivityDurationPresenter()
    private let activityStrainPresenter = ActivityStrainPresenter()
    
    init(modelManager: ModelManager) {
        self.modelManager = modelManager
        //activityList = modelManager.getActivities()
        //modelManager.getActivities(PARAMETERS) { [weak self] activities in
        //  self.activityList = activities
        //}
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
        view.createActivityButtonView.addAction(UIAction {[weak self] _ in
            if let changeNameCallback = self?.changeNameCallback,
               let activity = self?.modelManager.createActivity(),
               let activityList = self?.activityList {
                    
                    // incert new symptom into local symptomList at index 0
                    self?.activityList.insert(activity, at: 0)
                
                    // Save symptom in db
                    //self?.modelManager.updateActivities(activities: activityList) - Method for saving/updating a single activity needs to exist
                
                    // Run callback to navigate back to symptom list page
                    changeNameCallback(activity)
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
            changeNameCallback?(activityList[indexPath.row])
        }
    }
    
    // Method for setting editing style on cell.
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movingActivity = activityList.remove(at: sourceIndexPath.row)
        activityList.insert(movingActivity, at: destinationIndexPath.row)
        
        // modelManager.updateActivities(activities: activityList) - Activity does not include an editable position like Symptom, so this can't work
    }
}

extension ActivityViewModel: UITableViewDataSource {
    
    // How many sections
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // How many rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activityList.count
    }
    
    // Method for configuring row height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    // Choose cell type for each row and configure it.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath)
        if let activityCell = cell as? ActivityCell {
            activityCell.configureCell(activity: activityList[indexPath.row], presentDurationCallback: activityDurationPresenter.getDurationStringForMinutes, presentActivityStrainColorCallback: activityStrainPresenter.getActivityColorForStrain) { [weak self] activity in
                self?.modelManager.update(activity: activity)
            }
        }
        return cell
    }
    
    // For when user chooses to delete a activity from activitylist in editing state
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        // Delete activity frem db
        let activityToDelete = activityList[indexPath.row]
        modelManager.delete(activity: activityToDelete)
        
        //Remove activity from local list
        activityList.remove(at: indexPath.row)
        
        // Update view
        // The tableView taken as param above (and used here) refers to self.view.
        tableView.deleteRows(at: [indexPath], with: .fade)
    }
}
    
