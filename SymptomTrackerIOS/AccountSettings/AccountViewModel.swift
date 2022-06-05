//
//  AccountSettingsViewModel.swift
//  SymptomTrackerIOS
//
//  Created by Kira Nim on 15/05/2022.
//

import Foundation
import UIKit

final class AccountViewModel: NSObject {
    
    private var view: AccountView? = nil
    public var modelManager: AccountModelManager
    private let cellReuseIdentifier =  "cell"
    public var afterLogoutCallback: (()->Void)? = nil
    public var afterPasswordChangeCallback: (()->Void)? = nil
    public var symptomListSelectedCallback: (()->Void)? = nil
    
    private lazy var accountSettingsOptionsList: [(String, () -> Void)] = {
        [(LocalizedStrings.shared.logOutButtonText, logOut), (LocalizedStrings.shared.settingsListSymptomListItem, navigateToSymptomList)]
    }()
    
    // MARK: Init
    init(modelManager: AccountModelManager) {
        self.modelManager = modelManager
    }
    
    // MARK: Set view
    public func setView(view: AccountView) {
        view.delegate = self
        view.dataSource = self
        
        // To make sure that a cell of type UITableViewCell is now available to the tableView.
        view.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        self.view = view
    }
    
    // MARK: Other functionality
    private func logOut() {
        modelManager.logOut(logOutCompletionCallback: afterLogoutCallback)
    }
    
    private func navigateToSymptomList() {
        symptomListSelectedCallback?()
    }
}

// MARK: Extension - UITableViewDelegate

// Extension containing logit required for UITableViewDelegate protocol
extension AccountViewModel: UITableViewDelegate {
    
    // Method for when a row is selected by user.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedSubject = accountSettingsOptionsList[indexPath.row]
        
        // Get functionality to be run when row is selected - run it
        let selectedRowFunctionality = accountSettingsOptionsList[indexPath.row].1
        selectedRowFunctionality()
        
        view?.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: Extension - UITableViewDataSource

// Extension containing logit required for UITableViewDataSource protocol
extension AccountViewModel: UITableViewDataSource {
    
    // How many sections
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // How many rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accountSettingsOptionsList.count
    }
    
    // Method for configuring row height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
    // Choose cell type for each row and configure it.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        cell.textLabel?.text = accountSettingsOptionsList[indexPath.row].0
        cell.textLabel?.textColor = UIColor.appColor(name: .textBlack)
        cell.textLabel?.font = .appFont(ofSize: 17, weight: .medium)
        return cell
    }
}
