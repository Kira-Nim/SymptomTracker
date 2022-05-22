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
    
    init(modelManager: ModelManager) {
        self.modelManager = modelManager
    }
    
    public func setView(view: ActivityView) {
        self.view = view
    }
}

extension ActivityViewModel: UITableViewDelegate {
    
}

extension ActivityViewModel: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellReuseIdentifier", for: indexPath)

        cell.textLabel?.text = "Hello world"
    
        return cell
    }
    
    
}
    
