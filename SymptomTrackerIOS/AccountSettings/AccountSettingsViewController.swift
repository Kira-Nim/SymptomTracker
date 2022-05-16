//
//  AccountSettingsViewController.swift
//  SymptomTrackerIOS
//
//  Created by Kira Nim on 15/05/2022.
//

import Foundation
import UIKit

class AccountSettingsViewController: UIViewController {
    
    private var accountSettingsViewModel: AccountSettingsViewModel
    
    init(viewModel: AccountSettingsViewModel) {
        accountSettingsViewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
        
        title = "Konto"
        tabBarItem = UITabBarItem(title: title, image: UIImage(named: "icons8-combo-chart-30"), tag: 0)
        //tabBarItem = UITabBarItem(title: "Indsigt", image: UIImage(named: "icons8-slider-30"), tag: 0)
        
        let accountSettingsView = AccountSettingsView()
        view = accountSettingsView
        accountSettingsViewModel.setView(view: accountSettingsView)
    }
    
    //Formel requirement for all ViewControllers to have this initializer.
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


