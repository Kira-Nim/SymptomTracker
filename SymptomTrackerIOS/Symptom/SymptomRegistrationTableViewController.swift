//
//  RegistrationTableViewController.swift
//  SymptomTrackerIOS
//
//  Created by Kira Nim on 15/05/2022.
//

import Foundation
import UIKit

class SymptomRegistrationTableViewController: UITableViewController {
    
    private var symptomRegistrationViewModel: SymptomRegistrationViewModel
    
    init(viewModel: SymptomRegistrationViewModel) {
        symptomRegistrationViewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
        
        
    }
    
    //Formel requirement for all ViewControllers to have this initializer.
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
