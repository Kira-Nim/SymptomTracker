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
        
        title = "Indsigt"
        tabBarItem = UITabBarItem(title: title, image: UIImage(named: "icons8-combo-chart-30"), tag: 0)
        //tabBarItem = UITabBarItem(title: "Indsigt", image: UIImage(named: "icons8-slider-30"), tag: 0)
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
}
