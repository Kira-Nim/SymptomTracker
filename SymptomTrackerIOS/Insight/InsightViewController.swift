//
//  InsightViewController.swift
//  SymptomTrackerIOS
//
//  Created by Kira Nim on 15/05/2022.
//

import Foundation
import UIKit

final class InsightViewController: UIViewController {
    
    private var insightViewModel: InsightViewModel
    private lazy var insightView = InsightView()
    
    init(viewModel: InsightViewModel) {
        insightViewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
        
        title = LocalizedStrings.shared.tabbarInsightText
        tabBarItem = UITabBarItem(title: title, image: UIImage(named: "Insight"), tag: 0)
        
        navigationItem.rightBarButtonItem = viewModel.navigationBarButtonItem
    }
    
    //Formel requirement for all ViewControllers to have this initializer.
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = insightView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        insightViewModel.setView(view: insightView)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        let value = UIInterfaceOrientation.portrait.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
        UIViewController.attemptRotationToDeviceOrientation()
    }
}
