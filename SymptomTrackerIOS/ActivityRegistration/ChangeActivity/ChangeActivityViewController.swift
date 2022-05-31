//
//  changeActivityViewController.swift
//  SymptomTrackerIOS
//
//  Created by Kira Nim on 30/05/2022.
//

import Foundation
import UIKit

class ChangeActivityViewController: UIViewController {
    private var changeActivityViewModel: ChangeActivityViewModel
    private lazy var changeActivityView = ChangeActivityView()
    
    init(viewModel: ChangeActivityViewModel) {
        changeActivityViewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
        
        if viewModel.activity.name == "" {
            title = LocalizedStrings.shared.createActivityControllerTitle
        } else {
            title = LocalizedStrings.shared.editActivityControllerTitle
        }
        
        let saveActivityAction = UIAction {[weak self] _ in
            self?.changeActivityViewModel.saveActivity()
        }
        navigationItem.rightBarButtonItem = UIBarButtonItem(systemItem: UIBarButtonItem.SystemItem.save, primaryAction: saveActivityAction, menu: nil)
    }
    
    //Formel requirement for all ViewControllers to have this initializer.
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: loadView()
    override func loadView() {
        view = changeActivityView
    }
    
    // MARK: viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        changeActivityViewModel.setView(view: changeActivityView)
    }
    
    // MARK: viewDidAppear
    override func viewDidAppear(_ animated: Bool) {
        changeActivityViewModel.viewDidAppear()
    }
    
    // MARK: Other
    
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
