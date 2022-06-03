//
//  InsightViewModel.swift
//  SymptomTrackerIOS
//
//  Created by Kira Nim on 15/05/2022.
//

import Foundation
import UIKit

final class InsightViewModel: NSObject {
    
    public var presentSelectFromSymptomListController: (() -> Void)?
    private var view: InsightView? = nil
    public var modelManager: ModelManager
    public var navigationBarButtonItem = UIBarButtonItem()
    
    init(modelManager: ModelManager) {
        self.modelManager = modelManager
        super.init()
        self.navigationBarButtonItem = UIBarButtonItem(title: LocalizedStrings.shared.insightNavigationItemText, image: nil, primaryAction: UIAction {[weak self] _ in
            self?.presentSelectFromSymptomListController?()
        }, menu: nil)
    }
    
    public func setView(view: InsightView) {
        self.view = view
    }
}

extension InsightViewModel: UITableViewDelegate {
    
}

extension InsightViewModel: UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellReuseIdentifier", for: indexPath)

        cell.textLabel?.text = "Hello world"
    
        return cell
    }
}
