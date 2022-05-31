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
        title = LocalizedStrings.shared.activityControllerTitle
        tabBarItem = UITabBarItem(title: title, image: UIImage(named: "Activity"), tag: 0)
        navigationItem.rightBarButtonItem = editButtonItem
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
        activityViewModel.setView(view: activityView)
    }
    
    //MARK: Other
    
    /* This function overrides the getter function on UIViewController that returns the
       property supportedInterfaceOrientations which is used by iOS to understand what
       screen orientations is allowed. Default is .all
       This is needed because the supportedInterfaceOrientations proporty is a get only
       proporty.
       This way iOS will not ask the super but this controller and it get .portrait returnes as answer
     */
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
}
