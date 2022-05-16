//
//  RegistrationTableViewController.swift
//  SymptomTrackerIOS
//
//  Created by Kira Nim on 15/05/2022.
//

import Foundation
import UIKit

class SymptomRegistrationViewController: UIViewController {
    
    private var symptomRegistrationViewModel: SymptomRegistrationViewModel
    
    init(viewModel: SymptomRegistrationViewModel) {
        symptomRegistrationViewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
        
        title = "Symptomer"
        tabBarItem = UITabBarItem(title: title, image: UIImage(named: "icons8-combo-chart-30"), tag: 0)
        //tabBarItem = UITabBarItem(title: "Registration", image: UIImage(named: "icons8-slider-30"), tag: 0)
        
        let symptomRegistrationView = SymptomRegistrationView()
        view = symptomRegistrationView
        symptomRegistrationViewModel.setView(view: symptomRegistrationView)
    }
    
    //Formel requirement for all ViewControllers to have this initializer.
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
