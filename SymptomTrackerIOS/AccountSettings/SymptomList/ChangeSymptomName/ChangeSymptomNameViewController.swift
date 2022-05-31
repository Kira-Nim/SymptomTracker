//
//  ChangeSymptomNameViewController.swift
//  SymptomTrackerIOS
//
//  Created by Kira Nim on 24/05/2022.
//

import Foundation
import UIKit

class ChangeSymptomNameViewController: UIViewController {
    private var changeSymptomNameViewModel: ChangeSymptomNameViewModel
    private lazy var changeSymptomNameView = ChangeSymptomNameView()
    
    // MARK: Init
    init(viewModel: ChangeSymptomNameViewModel) {
        changeSymptomNameViewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
        
        if viewModel.symptom.name == "" {
            title = LocalizedStrings.shared.createSymptomControllerTitle
        } else {
            title = LocalizedStrings.shared.editSymptomControllerTitle
        }
        
        let saveSymptomAction = UIAction {[weak self] _ in
            self?.changeSymptomNameViewModel.saveSymptomName()
        }
        navigationItem.rightBarButtonItem = UIBarButtonItem(systemItem: UIBarButtonItem.SystemItem.save, primaryAction: saveSymptomAction, menu: nil)
    }
    //Formel requirement for all ViewControllers to have this initializer.
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: loadView()
    override func loadView() {
        view = changeSymptomNameView
    }
    
    // MARK: viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        changeSymptomNameViewModel.setView(view: changeSymptomNameView)
    }
    
    // MARK: viewDidAppear
    override func viewDidAppear(_ animated: Bool) {
        changeSymptomNameViewModel.viewDidAppear()
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
