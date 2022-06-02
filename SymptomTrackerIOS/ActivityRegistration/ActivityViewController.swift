//
//  ActivityViewController.swift
//  SymptomTrackerIOS
//
//  Created by Kira Nim on 15/05/2022.
//

import Foundation
import UIKit

final class ActivityViewController: UIViewController {
    private var activityViewModel: ActivityViewModel
    private lazy var activityView = ActivityView()
    private lazy var navbarView = NavBarDatePickerView()
    
    init(viewModel: ActivityViewModel) {
        activityViewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
        title = LocalizedStrings.shared.activityControllerTitle
        tabBarItem = UITabBarItem(title: title, image: UIImage(named: "Activity"), tag: 0)
        navigationItem.rightBarButtonItem = editButtonItem
        navigationItem.titleView = navbarView
    }
    
    override func setEditing(_ state:Bool, animated: Bool) {
        super.setEditing(state, animated: animated)
        activityViewModel.setEditing(state, animated: animated)
        
    }
    
    //Formel requirement for all ViewControllers to have this initializer.
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: loadView()
    override func loadView() {
        view = activityView
    }
    
    // MARK: viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        activityViewModel.setView(view: activityView, navbarView: navbarView)
    }
        
    //MARK: Other
}
