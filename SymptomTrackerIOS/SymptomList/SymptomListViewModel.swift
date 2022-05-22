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
    
    init(modelManager: ModelManager) {
        self.modelManager = modelManager
    }
    
    public func setView(view: SymptomListView) {
        view.delegate = self
        view.dataSource = self
        
        // To make sure that a cell of type SymptomListCell is now available to the tableView.
        view.register(SymptomListCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        self.view = view
    }
}

extension SymptomListViewModel: UITableViewDelegate {
    
    // Method for when a row is selected by user.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
}

extension SymptomListViewModel: UITableViewDataSource {

    // How many sections
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // How many rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    // Method for configuring row height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    // Choose cell type for each row and configure it.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath)
        
        if let symptomListCell = cell as? SymptomListCell {
        // configure cell here: symptomListCell.configureCell(data: somedata, callback: somecallback)
        }
        
        return cell
    }
}

