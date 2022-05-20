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
    
    init(viewModel: ActivityViewModel) {
        activityViewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
        
        title = "Aktivitet"
        tabBarItem = UITabBarItem(title: title, image: UIImage(named: "icons8-combo-chart-30"), tag: 0)
        //tabBarItem = UITabBarItem(title: "Aktivitet", image: UIImage(named: "icons8-slider-30"), tag: 0)
    }
    
    //Formel requirement for all ViewControllers to have this initializer.
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = activityView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityViewModel.setView(view: activityView)
    }
}
