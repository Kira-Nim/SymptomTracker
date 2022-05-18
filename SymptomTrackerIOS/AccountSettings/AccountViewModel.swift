//
//  AccountSettingsViewModel.swift
//  SymptomTrackerIOS
//
//  Created by Kira Nim on 15/05/2022.
//

import Foundation
import UIKit

class AccountViewModel: NSObject {
    
    private var view: AccountView? = nil
    public var modelManager: ModelManager
    private let cellReuseIdentifier =  "cell"
    public var afterLogoutCallback: (()->Void)? = nil
    public var afterPasswordChangeCallback: (()->Void)? = nil
    
    private lazy var accountSettingsOptionsList: [(String, () -> Void)] = {
        [("Log ud", logOut), ("Skift password", changePassword)]
    }()
    
    init(modelManager: ModelManager) {
        self.modelManager = modelManager
    }
    
    public func setView(view: AccountView) {
        view.delegate = self
        view.dataSource = self
        
        // To make sure that a cell of type UITableViewCell is now available to the tableView.
        view.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        self.view = view
    }
    
    private func logOut() {
        modelManager.logOut(logOutCompletionCallback: afterLogoutCallback)
    }
    
    private func changePassword(email: String?) {
        
        if let email = email {
            self.modelManager.changePassword(email: email) { [weak self] (identifyer) in
                self?.showErrorMessageFor(identifyer: identifyer)
            }
        }
    }

    private func showErrorMessageFor(identifyer: ChangePasswordResult){

        print("Test ChangePasswordResult...................................")
        print(identifyer)
        /*
        switch (identifyer) {
        case .changeSucceded:
            view?.errorMessage.text = ""
            afterPasswordChangeCallback?()

        case .weakPasswordError:
            view?.errorMessage.text = "Password skal indeholde minimum 6 tegn"
            
        default:
            view?.errorMessage.text = "Ændring af password fejlede"
         */
    }
         
}

// Extension containing logit required for UITableViewDelegate protocol
extension AccountViewModel: UITableViewDelegate {
    
    // Method for when a row is selected by user.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedSubject = accountSettingsOptionsList[indexPath.row]
        
        // Get functionality to be run when row is selected - run it
        let selectedRowFunctionality = accountSettingsOptionsList[indexPath.row].1
        selectedRowFunctionality()
    }
}

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
    
    // Choose cell type for each row and configure it.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        cell.textLabel?.text = accountSettingsOptionsList[indexPath.row].0
        return cell
    }
}
