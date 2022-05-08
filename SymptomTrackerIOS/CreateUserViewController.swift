//
//  CreateUserViewController.swift
//  SymptomTrackerIOS
//
//  Created by Kira Nim on 08/05/2022.
//

import Foundation
import UIKit

class CreateUserViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let view = CreateUserView()
        view.setupSubViews()
    }
}
