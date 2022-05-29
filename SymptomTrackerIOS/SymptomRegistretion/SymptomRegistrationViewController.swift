//
//  RegistrationTableViewController.swift
//  SymptomTrackerIOS
//
//  Created by Kira Nim on 15/05/2022.
//

import Foundation
import UIKit

final class SymptomRegistrationViewController: UIViewController {
    private var symptomRegistrationViewModel: SymptomRegistrationViewModel
    private lazy var symptomRegistrationView = SymptomRegistrationView()
    private lazy var navbarView = SymptomRegistrationNavbarView()
    
    // MARK: Init
    init(viewModel: SymptomRegistrationViewModel) {
        symptomRegistrationViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
        title = LocalizedStrings.shared.tabbarRegistrationsText
        tabBarItem = UITabBarItem(title: title, image: UIImage(named: "Symptoms"), tag: 0)
        
        navigationItem.titleView = navbarView
    }
    //Formel requirement for all ViewControllers to have this initializer.
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = symptomRegistrationView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        symptomRegistrationViewModel.setView(view: symptomRegistrationView, navbarView: navbarView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        symptomRegistrationViewModel.viewWillAppear()
    }
}
