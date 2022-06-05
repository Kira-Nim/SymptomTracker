//
//  SymptomViewModel.swift
//  SymptomTrackerIOS
//
//  Created by Kira Nim on 21/05/2022.
//

import Foundation
import UIKit

final class SymptomListViewModel: NSObject {
    private var view: SymptomListView?
    public var modelManager: ModelManager
    private let cellReuseIdentifier =  "cell"
    private var symptomList: [Symptom]
    public var changeNameCallback: ((Symptom) -> Void)?
    
//MARK: Init
    init(modelManager: ModelManager) {
        self.modelManager = modelManager
        symptomList = modelManager.getSymptoms()
    }
    
    public func setView(view: SymptomListView) {
        view.symptomsTableView.delegate = self
        view.symptomsTableView.dataSource = self
        view.symptomsTableView.allowsSelectionDuringEditing = true
        
        // To make sure that a cell of type SymptomListCell is now available to the tableView.
        view.symptomsTableView.register(SymptomListCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        self.view = view
        
        
        // set functionality to be executed when create new symptom confirmation button is tapped
        view.createSymptomButtonView.addAction(UIAction {[weak self] _ in
            if let changeNameCallback = self?.changeNameCallback,
               let symptom = self?.modelManager.createSymptom(sortingPlacement: 0),
               let symptomList = self?.symptomList {
                    
                    // incert new symptom into local symptomList at index 0
                    self?.symptomList.insert(symptom, at: 0)
                
                    // reset sortingPlacement attribrutes on all symptoms in symptomList
                    // to match their new index in list
                    for (index, symptom) in symptomList.enumerated() {
                        symptom.sortingPlacement = index
                    }
                
                    // Save symptom in db
                    self?.modelManager.updateSymptoms(symptoms: symptomList)
                
                    // Run callback to navigate back to symptom list page
                    changeNameCallback(symptom)
            }
        }, for: .touchUpInside)
    }
    
    // When OS calles setEditing() on SymptomListViewController, the controller will call this method.
    public func setEditing(_ state: Bool, animated: Bool) {
        view?.symptomsTableView.setEditing(state, animated: animated)
        
        if let view = view {
            if state {
                view.buttonContentViewConstraint?.constant = 75
                view.createSymptomButtonViewConstraint?.constant = 38
            } else {
                view.buttonContentViewConstraint?.constant = 0
                view.createSymptomButtonViewConstraint?.constant = 0
            }
        }
    }
    
    public func updateView() {
        view?.symptomsTableView.reloadData()
    }
}

//MARK: Extension implementing UITableViewDelegate
extension SymptomListViewModel: UITableViewDelegate {
    
    // Method for when a row is selected by user.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Only navigate to change symptom name page if the symptom name is selected in editing mode
        // tableView refers to self.view
        if tableView.isEditing {
            changeNameCallback?(symptomList[indexPath.row])
        }
    }
    
    // Method for setting editing style on cell.
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movingSymptom = symptomList.remove(at: sourceIndexPath.row)
        symptomList.insert(movingSymptom, at: destinationIndexPath.row)
        
        for (index, symptom) in symptomList.enumerated() {
            symptom.sortingPlacement = index
        }
        modelManager.updateSymptoms(symptoms: symptomList)
    }
}

//MARK: Extension implementing UITableViewDataSource
extension SymptomListViewModel: UITableViewDataSource {

    // How many sections
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // How many rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return symptomList.count
    }
    
    // Method for configuring row height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    // Choose cell type for each row and configure it.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath)
        if let symptomListCell = cell as? SymptomListCell {
            symptomListCell.configureCell(symptom: symptomList[indexPath.row]) { symptom in
                self.modelManager.updateSymptom(symptom: symptom)
            }
        }
        return cell
    }
    
    // For when user chooses to delete a symptom from symptomlist in editing state
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        // Delete symptom frem db
        let symptomToDelete = symptomList[indexPath.row]
        modelManager.delete(symptom: symptomToDelete)
        
        //Remove symptom from local list
        symptomList.remove(at: indexPath.row)
        
        // Update view
        // The tableView taken as param above (and used here) refers to self.view.
        tableView.deleteRows(at: [indexPath], with: .fade)
    }
}
