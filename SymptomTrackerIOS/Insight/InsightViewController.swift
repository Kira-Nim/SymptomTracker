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
    private lazy var navBarView = NavBarDatePickerView()
    
    // MARK: init()
    
    init(viewModel: InsightViewModel) {
        insightViewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
        
        title = LocalizedStrings.shared.tabbarInsightText
        tabBarItem = UITabBarItem(title: title, image: UIImage(named: "Insight"), tag: 0)
        navigationItem.titleView = navBarView
        navigationItem.rightBarButtonItem = viewModel.navigationBarButtonItem
        
    }
    
    //Formel requirement for all ViewControllers to have this initializer.
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: loadView
    
    override func loadView() {
        view = insightView
    }
    
    // MARK: viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        insightViewModel.setView(view: insightView, navbarView: navBarView)
    }
    
    // MARK: viewDidAppear
    
    override func viewDidDisappear(_ animated: Bool) {
        let value = UIInterfaceOrientation.portrait.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
        UIViewController.attemptRotationToDeviceOrientation()
    }
    
    // MARK: viewWillAppear
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        insightViewModel.viewWillAppear()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        if UIDevice.current.orientation.isLandscape {
            print("Landscape")
            self.navigationController?.setNavigationBarHidden(true, animated: true)
            self.tabBarController?.tabBar.isHidden = true
            self.insightViewModel.willTransitionTo(landscape: true)
        } else {
            print("Portrait")
            self.navigationController?.setNavigationBarHidden(false, animated: true)
            self.tabBarController?.tabBar.isHidden = false
            self.insightViewModel.willTransitionTo(landscape: false)
        }
    }
}
