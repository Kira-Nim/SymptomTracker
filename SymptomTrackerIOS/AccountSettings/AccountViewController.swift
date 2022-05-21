//
//  AccountSettingsViewController.swift
//  SymptomTrackerIOS
//
//  Created by Kira Nim on 15/05/2022.
//

import Foundation
import UIKit

class AccountViewController: UIViewController {
    
    private var accountSettingsViewModel: AccountViewModel
    private lazy var accountSettingsView = AccountView()
    
    init(viewModel: AccountViewModel) {
        accountSettingsViewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
        
        title = LocalizedStrings.shared.tabbarAccountText
        tabBarItem = UITabBarItem(title: title, image: UIImage(named: "icons8-combo-chart-30"), tag: 0)
        //tabBarItem = UITabBarItem(title: "Indsigt", image: UIImage(named: "icons8-slider-30"), tag: 0)
    }
    
    //Formel requirement for all ViewControllers to have this initializer.
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = accountSettingsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        accountSettingsViewModel.setView(view: accountSettingsView)
    }
}


