//
//  SymptomViewModel.swift
//  SymptomTrackerIOS
//
//  Created by Kira Nim on 21/05/2022.
//

import Foundation
import UIKit

final class SymptomListViewModel: NSObject {
    private var view: SymptomListView? = nil
    public var modelManager: ModelManager
    private let cellReuseIdentifier =  "cell"
    private var symptomList: [Symptom]
    
//MARK: Init
    init(modelManager: ModelManager) {
        self.modelManager = modelManager
        symptomList = modelManager.getSymptoms()
    }
    
    public func setView(view: SymptomListView) {
        view.delegate = self
        view.dataSource = self
        
        // To make sure that a cell of type SymptomListCell is now available to the tableView.
        view.register(SymptomListCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        self.view = view
    }
    
    public func changeEditingStateTo(_ state: Bool, animated: Bool) {
        view?.setEditing(state, animated: animated)
    }
}

//MARK: Extension implementing UITableViewDelegate
extension SymptomListViewModel: UITableViewDelegate {
    
    // Method for when a row is selected by user.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Code for when row is selected
    }
    
    // Method for setting editing style on cell.
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return.delete
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        var movingSymptom = symptomList.remove(at: sourceIndexPath.row)
        symptomList.insert(movingSymptom, at: destinationIndexPath.row)
        
        for (index, var symptom) in symptomList.enumerated() {
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
