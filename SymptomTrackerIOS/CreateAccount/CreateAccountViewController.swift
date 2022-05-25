//
//  CreateUserViewController.swift
//  SymptomTrackerIOS
//
//  Created by Kira Nim on 08/05/2022.
//

import Foundation
import UIKit


final class CreateAccountViewController: UIViewController {
    private let createAccountViewModel: CreateAccountViewModel
    private lazy var contentView = CreateAccountView()
    
    //MARK: Init
    init(viewModel: CreateAccountViewModel) {
        createAccountViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    /*
    Formel requirement for all ViewControllers to have this initializer.
    This is not a initializer that is going to be used
    It has to do with the ability to serialize and deserialize.
  
    Explained:
    When we choose to make an initializer in this class in stead of using the super's initialiser, then we waive the rights to all the supers initializers but the one choosen.
    Because of this, this initializer needs to be implemented here.
    It would have been part of the super "TableViewController" and supersuper "ViewController" if we hadn't implemented our own initializer.
     */
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: loadView()
    override func loadView() {
        view = contentView
    }
    
    // MARK: viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        createAccountViewModel.setView(view: contentView)
    }
}
