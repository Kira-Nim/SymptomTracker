//
//  SymptomRegistrationViewModel.swift
//  SymptomTrackerIOS
//
//  Created by Kira Nim on 15/05/2022.
//

import Foundation
import UIKit

final class SymptomRegistrationViewModel: NSObject {
    
    private var view: SymptomRegistrationView?
    private var navbarView: UIView?
    private let cellReuseIdentifier =  "cellReuseIdentifier"
    public var modelManager: ModelManager
    private var symptomList: [String] = ["Hello", "hello", "World", "World", "Hello", "hello", "World", "World","Hello", "hello", "World", "World"]
    
    init(modelManager: ModelManager) {
        self.modelManager = modelManager
        //symptomList = modelManager.getSymptoms()
        print(symptomList.count)
    }
    
    public func setView(view: SymptomRegistrationView, navbarView: SymptomRegistrationNavbarView) {
        self.view = view
        self.navbarView = navbarView
        view.registrationTableView.delegate = self
        view.registrationTableView.dataSource = self
        
        // To make sure that a cell of type SymptomRegistrationCell is now available to the tableView.
        view.registrationTableView.register(SymptomRegistrationCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        self.view = view
    }
    
    //MARK: updateView()
    public func updateView() {
        view?.registrationTableView.reloadData()
    }
}

extension SymptomRegistrationViewModel: UITableViewDelegate {
    
}

extension SymptomRegistrationViewModel: UITableViewDataSource {
    
    // How many sections
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // How many rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return symptomList.count
    }
    
    // Method responsible for declaring whitch cell type should be used for each row and for configuring that cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath)
        if let symptomRegistrationCell = cell as?  SymptomRegistrationCell {
            //symptomRegistrationCell.configureCell(symptom: symptomList[indexPath.row])
            print("made a cell")
        }
        return cell
    }
    
    // Method for configuring row height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 97
    }
}
