//
//  SymptomRegistrationViewModel.swift
//  SymptomTrackerIOS
//
//  Created by Kira Nim on 15/05/2022.
//

import Foundation
import UIKit

final class SymptomRegistrationViewModel: NSObject {
    
    private var view: SymptomRegistrationView? = nil
    public var modelManager: ModelManager
    
    init(modelManager: ModelManager) {
        self.modelManager = modelManager
    }
    
    public func setView(view: SymptomRegistrationView) {
        self.view = view
    }
}

extension SymptomRegistrationViewModel: UITableViewDelegate {
    
}

extension SymptomRegistrationViewModel: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellReuseIdentifier", for: indexPath)

        cell.textLabel?.text = "Hello world"
    
        return cell
    }
}
